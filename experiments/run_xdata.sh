#!/bin/bash
set -e

# If invoked with sh and bash is available, re-exec with bash for full environment support
if [ -z "$BASH_VERSION" ]; then
    if command -v bash >/dev/null 2>&1; then
        exec bash "$0" "$@"
    fi
fi

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

# Ensure databases are up and healthy
. "$DIR/start_databases.sh"

PG_PORT="${POSTGRES_PORT:-54320}"
if [ -z "$POSTGRES_PORT" ]; then
    echo ""
    echo "=================================================================="
    echo "[ERROR] PostgreSQL is not running or accessible on port 54320 or 5432."
    echo "XData requires a running PostgreSQL database backend to generate test datasets."
    echo ""
    echo "Please ensure Docker Desktop is running and start the containers:"
    echo "  docker compose -f \"$DIR/../docker-compose.yml\" up -d"
    echo "=================================================================="
    exit 1
fi

if ! command -v java >/dev/null 2>&1; then
    echo "Error: Java runtime (java) is not found. Please install a Java Runtime Environment (JRE/JDK 11+)."
    exit 1
fi

# Detect Python 3.8+ interpreter
PYTHON_CMD=""
for cmd in python3 python3.12 python3.11 python3.10 python; do
    if command -v "$cmd" >/dev/null 2>&1 && "$cmd" -c "import sys; sys.exit(0 if sys.version_info >= (3,8) else 1)" >/dev/null 2>&1; then
        PYTHON_CMD="$cmd"
        break
    fi
done

if [ -z "$PYTHON_CMD" ]; then
    echo "Error: Python 3.8 or higher is required but not found."
    exit 1
fi

# Check if venv exists, create if not
if [ -d "$DIR/originals/.xdata_venv" ] && [ -f "$DIR/originals/.xdata_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/originals/.xdata_venv/bin/python"
    PIP_EXEC="$DIR/originals/.xdata_venv/bin/pip"
    export PATH="$DIR/originals/.xdata_venv/bin:$PATH"
elif [ -d "$DIR/.xdata_venv" ] && [ -f "$DIR/.xdata_venv/bin/python" ]; then
    PYTHON_EXEC="$DIR/.xdata_venv/bin/python"
    PIP_EXEC="$DIR/.xdata_venv/bin/pip"
    export PATH="$DIR/.xdata_venv/bin:$PATH"
else
    echo "Creating XData virtual environment..."
    "$PYTHON_CMD" -m venv "$DIR/originals/.xdata_venv" 2>/dev/null || "$PYTHON_CMD" -m virtualenv "$DIR/originals/.xdata_venv" 2>/dev/null || true
    if [ -f "$DIR/originals/.xdata_venv/bin/python" ]; then
        PYTHON_EXEC="$DIR/originals/.xdata_venv/bin/python"
        PIP_EXEC="$DIR/originals/.xdata_venv/bin/pip"
        export PATH="$DIR/originals/.xdata_venv/bin:$PATH"
    else
        PYTHON_EXEC="$PYTHON_CMD"
        PIP_EXEC="pip3"
    fi
fi

"$PIP_EXEC" install -q --upgrade pip 2>/dev/null || true
"$PIP_EXEC" install -q sqlglot tqdm questionary psycopg2-binary pymysql 2>/dev/null || \
"$PYTHON_EXEC" -m pip install -q sqlglot tqdm questionary psycopg2-binary pymysql 2>/dev/null || true
export PYTHON_EXEC

# Benchmark selection prompt (XData supports calcite, xdata, tpch, largejoin, and lasso-bm)
export ALLOWED_BENCHMARKS="calcite xdata tpch largejoin lasso-bm"
. "$DIR/select_benchmark.sh" "$@"

INPUT_OPT=""
if [ ! -z "$INPUT_FILE" ]; then
    INPUT_OPT="--input-file $INPUT_FILE"
fi

XDATA_DIR="$DIR/originals/XData-DataGen"
if [ ! -d "$XDATA_DIR" ]; then
    XDATA_DIR="$DIR/XData-DataGen"
fi

# Prepare XData sample data if missing
if [ ! -f "$XDATA_DIR/sample_data/manifest.json" ]; then
    echo "Preparing XData sample data..."
    "$PYTHON_EXEC" "$DIR/prepare_xdata_sample_data.py"
fi

mkdir -p "$XDATA_DIR/bin"
mkdir -p "$XDATA_DIR/tmp"

export LD_LIBRARY_PATH="$XDATA_DIR/Z3files:${LD_LIBRARY_PATH:-}"
export DYLD_LIBRARY_PATH="$XDATA_DIR/Z3files:${DYLD_LIBRARY_PATH:-}"

CLASSPATH="$XDATA_DIR/XData/jars/postgresql-42.7.4.jar:$XDATA_DIR/XData/jars/jsqlparser-5.0.jar:$XDATA_DIR/XData/jars/sqlbuilder-3.0.2.jar:$XDATA_DIR/XData/jars/com.microsoft.z3.jar:$XDATA_DIR/XData/jars/sqlite-jdbc-3.45.2.0.jar:$XDATA_DIR/XData/jars/tomcat-jdbc-7.0.54.jar:$XDATA_DIR/XData/jars/tomcat-juli-7.0.54.jar:$XDATA_DIR/XData/jars/automaton.jar:$XDATA_DIR/XData/jars/derby-10.8.jar:$XDATA_DIR/XData/jars/google-collect-1.0-rc2.jar:$XDATA_DIR/XData/jars/gson-2.2.4.jar:$XDATA_DIR/XData/jars/ojdbc6-11.2.0.2.0.jar:$XDATA_DIR/XData/jars/uncommons-maths-1.2.jar:$XDATA_DIR/XData/jars/mysql-connector-java-8.0.16.jar:$XDATA_DIR/XData/jars/slf4j-api-2.0.9.jar:."

# Check if XDataBridge class is missing or incompatible with current java runtime
NEED_COMPILE=0
if [ ! -f "$XDATA_DIR/bin/testDataGen/XDataBridge.class" ]; then
    NEED_COMPILE=1
elif ! java -Djava.library.path="$XDATA_DIR/Z3files" -cp "$XDATA_DIR/bin:$CLASSPATH" testDataGen.XDataBridge 2>&1 | grep -q "Usage: XDataBridge"; then
    echo "Notice: Existing XDataBridge.class is incompatible with current Java runtime ($(java -version 2>&1 | head -n 1)). Recompiling..."
    NEED_COMPILE=1
fi

if [ "$NEED_COMPILE" -eq 1 ]; then
    if command -v javac >/dev/null 2>&1; then
        echo "Compiling XData-DataGen..."
        javac -cp "$CLASSPATH" -d "$XDATA_DIR/bin" $(find "$XDATA_DIR/XData" -name "*.java")
    else
        echo "Error: javac not found and XDataBridge.class is missing or incompatible. Please install a JDK matching the class file version."
        exit 1
    fi
fi

mkdir -p "$XDATA_DIR/bin/util"
cp -f "$XDATA_DIR/XData/util/XData.properties" "$XDATA_DIR/bin/util/XData.properties" 2>/dev/null || true

# Robust Z3 detection
Z3_BIN="$(command -v z3 2>/dev/null || echo "")"
if [ -z "$Z3_BIN" ]; then
    for candidate in /opt/homebrew/bin/z3 /opt/homebrew/Caskroom/miniconda/base/bin/z3 /usr/local/bin/z3 "$HOME/miniconda3/bin/z3" "$HOME/anaconda3/bin/z3"; do
        if [ -x "$candidate" ]; then
            Z3_BIN="$candidate"
            export PATH="$(dirname "$candidate"):$PATH"
            break
        fi
    done
fi
if [ -z "$Z3_BIN" ]; then
    Z3_BIN="z3"
fi

# Update databasePort and smtsolver in XData.properties reliably using Python
"$PYTHON_EXEC" -c '
import sys, os
port = sys.argv[1]
z3_path = sys.argv[2]
for pfile in sys.argv[3:]:
    if not os.path.exists(pfile):
        continue
    with open(pfile, "r", encoding="utf-8") as f:
        lines = f.readlines()
    new_lines = []
    for line in lines:
        if line.strip().startswith("databasePort="):
            new_lines.append(f"databasePort={port}\n")
        elif line.strip().startswith("smtsolver="):
            new_lines.append(f"smtsolver={z3_path}\n")
        else:
            new_lines.append(line)
    with open(pfile, "w", encoding="utf-8") as f:
        f.writelines(new_lines)
' "$PG_PORT" "$Z3_BIN" "$XDATA_DIR/bin/util/XData.properties" "$XDATA_DIR/XData/util/XData.properties" 2>/dev/null || true

# On macOS, fix dynamic loader path for libz3java.dylib -> libz3.dylib
if [ "$(uname -s)" = "Darwin" ] && command -v install_name_tool >/dev/null 2>&1; then
    if [ -f "$XDATA_DIR/Z3files/libz3java.dylib" ]; then
        install_name_tool -change libz3.dylib @loader_path/libz3.dylib "$XDATA_DIR/Z3files/libz3java.dylib" 2>/dev/null || true
    fi
fi

# Native library path for Z3 JNI
export LD_LIBRARY_PATH="$XDATA_DIR/Z3files:${LD_LIBRARY_PATH:-}"
export DYLD_LIBRARY_PATH="$XDATA_DIR/Z3files:${DYLD_LIBRARY_PATH:-}"
export XDATA_ROOT="$XDATA_DIR"
export XDATA_BIN_DIR="$XDATA_DIR/bin"
export XDATA_JARS_DIR="$XDATA_DIR/XData/jars"
export XDATA_Z3_LIB_DIR="$XDATA_DIR/Z3files"
export JAVA_CLASSPATH="$XDATA_DIR/bin:$CLASSPATH"

for bm in $BENCHMARK; do
    echo "==========================================="
    echo "Running XData-DataGen benchmark: $bm"
    echo "==========================================="
    EXEC_RESUME_OPT="$RESUME_OPT"
    case " $* " in
        *" --retry "*|*" --resume "*|*" --full "*|*" --rerun "*) EXEC_RESUME_OPT="" ;;
    esac
    EXEC_BENCH_OPT=""
    if [ -n "$bm" ]; then
        case " $* " in
            *" --benchmark "*) ;;
            *) EXEC_BENCH_OPT="--benchmark $bm" ;;
        esac
    fi
    "$PYTHON_EXEC" "$DIR/evaluate_xdata.py" $EXEC_BENCH_OPT $INPUT_OPT $EXEC_RESUME_OPT $DIALECT_OPT "$@"
done

