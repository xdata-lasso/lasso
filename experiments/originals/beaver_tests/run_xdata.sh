#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
EXPERIMENTS_DIR="$( cd "$DIR/.." >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( cd "$EXPERIMENTS_DIR/.." >/dev/null 2>&1 && pwd )"

# Ensure databases are up and healthy
if [ -f "$EXPERIMENTS_DIR/start_databases.sh" ]; then
    . "$EXPERIMENTS_DIR/start_databases.sh"
fi

PG_PORT="${POSTGRES_PORT:-54320}"
if [ -z "$POSTGRES_PORT" ]; then
    echo "Warning: POSTGRES_PORT not set, defaulting to 54320"
    PG_PORT=54320
fi

if ! command -v java >/dev/null 2>&1; then
    echo "Error: Java runtime (java) is not found. Please install a JRE/JDK 11+."
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

# Setup XData virtual environment
if [ ! -d "$EXPERIMENTS_DIR/.xdata_venv" ]; then
    echo "Creating XData virtual environment..."
    "$PYTHON_CMD" -m venv "$EXPERIMENTS_DIR/.xdata_venv" 2>/dev/null || true
fi

if [ -f "$EXPERIMENTS_DIR/.xdata_venv/bin/python" ]; then
    PYTHON_EXEC="$EXPERIMENTS_DIR/.xdata_venv/bin/python"
    PIP_EXEC="$EXPERIMENTS_DIR/.xdata_venv/bin/pip"
else
    PYTHON_EXEC="$PYTHON_CMD"
    PIP_EXEC="pip3"
fi

"$PIP_EXEC" install -q sqlglot tqdm questionary psycopg2-binary pymysql 2>/dev/null || \
"$PYTHON_EXEC" -m pip install -q sqlglot tqdm questionary psycopg2-binary pymysql 2>/dev/null || true

mkdir -p "$EXPERIMENTS_DIR/XData-DataGen/bin"
mkdir -p "$EXPERIMENTS_DIR/XData-DataGen/tmp"

export LD_LIBRARY_PATH="$EXPERIMENTS_DIR/XData-DataGen/Z3files:${LD_LIBRARY_PATH:-}"
export DYLD_LIBRARY_PATH="$EXPERIMENTS_DIR/XData-DataGen/Z3files:${DYLD_LIBRARY_PATH:-}"

CLASSPATH="$EXPERIMENTS_DIR/XData-DataGen/XData/jars/postgresql-42.7.4.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/jsqlparser-5.0.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/sqlbuilder-3.0.2.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/com.microsoft.z3.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/sqlite-jdbc-3.45.2.0.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/tomcat-jdbc-7.0.54.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/tomcat-juli-7.0.54.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/automaton.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/derby-10.8.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/google-collect-1.0-rc2.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/gson-2.2.4.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/ojdbc6-11.2.0.2.0.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/uncommons-maths-1.2.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/mysql-connector-java-8.0.16.jar:$EXPERIMENTS_DIR/XData-DataGen/XData/jars/slf4j-api-2.0.9.jar:."

# Compile XDataBridge if needed
NEED_COMPILE=0
if [ ! -f "$EXPERIMENTS_DIR/XData-DataGen/bin/testDataGen/XDataBridge.class" ]; then
    NEED_COMPILE=1
elif ! java -Djava.library.path="$EXPERIMENTS_DIR/XData-DataGen/Z3files" -cp "$EXPERIMENTS_DIR/XData-DataGen/bin:$CLASSPATH" testDataGen.XDataBridge 2>&1 | grep -q "Usage: XDataBridge"; then
    NEED_COMPILE=1
fi

if [ "$NEED_COMPILE" -eq 1 ]; then
    if command -v javac >/dev/null 2>&1; then
        echo "Compiling XData-DataGen..."
        javac -cp "$CLASSPATH" -d "$EXPERIMENTS_DIR/XData-DataGen/bin" $(find "$EXPERIMENTS_DIR/XData-DataGen/XData" -name "*.java")
    else
        echo "Error: javac not found."
        exit 1
    fi
fi

mkdir -p "$EXPERIMENTS_DIR/XData-DataGen/bin/util"
cp -f "$EXPERIMENTS_DIR/XData-DataGen/XData/util/XData.properties" "$EXPERIMENTS_DIR/XData-DataGen/bin/util/XData.properties" 2>/dev/null || true

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

if [ -z "$Z3_BIN" ] && [ -x "$EXPERIMENTS_DIR/xdatapublic/z3/z3" ]; then
    Z3_BIN="$EXPERIMENTS_DIR/xdatapublic/z3/z3"
fi

"$PYTHON_EXEC" -c '
import sys, os
port, z3_path = sys.argv[1], sys.argv[2]
for pfile in sys.argv[3:]:
    if not os.path.exists(pfile): continue
    with open(pfile, "r", encoding="utf-8") as f: lines = f.readlines()
    new_lines = []
    for line in lines:
        if line.strip().startswith("databasePort="): new_lines.append(f"databasePort={port}\n")
        elif line.strip().startswith("smtsolver="): new_lines.append(f"smtsolver={z3_path}\n")
        else: new_lines.append(line)
    with open(pfile, "w", encoding="utf-8") as f: f.writelines(new_lines)
' "$PG_PORT" "$Z3_BIN" "$EXPERIMENTS_DIR/XData-DataGen/bin/util/XData.properties" 2>/dev/null || true

echo "=================================================================="
echo "Running XData Benchmark for Beaver (dw schema)"
echo "Postgres port: $PG_PORT"
echo "Python interpreter: $PYTHON_EXEC"
echo "=================================================================="

"$PYTHON_EXEC" "$DIR/test_beaver_xdata.py" --tool xdata "$@"
