#!/bin/bash
set -e

# If invoked with sh and bash is available, re-exec with bash for full environment support
if [ -z "$BASH_VERSION" ]; then
    if command -v bash >/dev/null 2>&1; then
        exec bash "$0" "$@"
    fi
fi

DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
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

# Paths for xdatapublic
PUBLIC_DIR="$EXPERIMENTS_DIR/xdatapublic"
XDATA_PUBLIC_BIN="$PUBLIC_DIR/bin"
XDATA_PUBLIC_JARS="$PUBLIC_DIR/xdata/jars"
XDATA_PUBLIC_Z3="$PUBLIC_DIR/xdata/z3"

mkdir -p "$XDATA_PUBLIC_BIN"
mkdir -p "$EXPERIMENTS_DIR/XData-DataGen/tmp"

# Native library path for Z3 from xdatapublic
export LD_LIBRARY_PATH="$XDATA_PUBLIC_Z3:${LD_LIBRARY_PATH:-}"
export DYLD_LIBRARY_PATH="$XDATA_PUBLIC_Z3:${DYLD_LIBRARY_PATH:-}"

# Classpath configured specifically for xdatapublic: using xdata.jar and compatible dependency versions
CLASSPATH="$XDATA_PUBLIC_BIN:$XDATA_PUBLIC_JARS/xdata.jar:$XDATA_PUBLIC_JARS/postgresql-42.7.4.jar:$XDATA_PUBLIC_JARS/jsqlparser.jar:$XDATA_PUBLIC_JARS/sqlbuilder-3.0.2.jar:$XDATA_PUBLIC_JARS/com.microsoft.z3.jar:$XDATA_PUBLIC_JARS/sqlite-jdbc-3.45.2.0.jar:$XDATA_PUBLIC_JARS/tomcat-jdbc-7.0.54.jar:$XDATA_PUBLIC_JARS/tomcat-juli-7.0.54.jar:$XDATA_PUBLIC_JARS/automaton.jar:$XDATA_PUBLIC_JARS/derby-10.8.jar:$XDATA_PUBLIC_JARS/google-collect-1.0-rc2.jar:$XDATA_PUBLIC_JARS/gson-2.2.4.jar:$XDATA_PUBLIC_JARS/ojdbc6-11.2.0.2.0.jar:$XDATA_PUBLIC_JARS/uncommons-maths-1.2.jar:$XDATA_PUBLIC_JARS/mysql-connector-java-8.0.16.jar:$XDATA_PUBLIC_JARS/slf4j-api-2.0.9.jar:."

# Check if XDataBridge class is missing or incompatible with current java runtime
NEED_COMPILE=0
if [ ! -f "$XDATA_PUBLIC_BIN/testDataGen/XDataBridge.class" ]; then
    NEED_COMPILE=1
elif ! java -Djava.library.path="$XDATA_PUBLIC_Z3" -cp "$CLASSPATH" testDataGen.XDataBridge 2>&1 | grep -q "Usage: XDataBridge"; then
    NEED_COMPILE=1
fi

if [ "$NEED_COMPILE" -eq 1 ]; then
    if command -v javac >/dev/null 2>&1; then
        echo "Compiling XDataBridge for xdatapublic..."
        javac -cp "$CLASSPATH" -d "$XDATA_PUBLIC_BIN" "$EXPERIMENTS_DIR/XData-DataGen/XData/testDataGen/XDataBridge.java"
    else
        echo "Error: javac not found."
        exit 1
    fi
fi

mkdir -p "$XDATA_PUBLIC_BIN/util"
cp -f "$EXPERIMENTS_DIR/XData-DataGen/XData/util/XData.properties" "$XDATA_PUBLIC_BIN/util/XData.properties" 2>/dev/null || true

# Robust Z3 detection: prefer xdatapublic native z3 binary if executable
Z3_BIN="$XDATA_PUBLIC_Z3/z3"
if [ ! -x "$Z3_BIN" ]; then
    Z3_BIN="$(command -v z3 2>/dev/null || echo "z3")"
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
' "$PG_PORT" "$Z3_BIN" "$XDATA_PUBLIC_BIN/util/XData.properties" 2>/dev/null || true

# Export environment variables for test_beaver_xdata.py
export XDATA_TOOL_NAME="xdatapublic"
export XDATA_ROOT="$PUBLIC_DIR"
export XDATA_BIN_DIR="$XDATA_PUBLIC_BIN"
export XDATA_JARS_DIR="$XDATA_PUBLIC_JARS"
export XDATA_Z3_LIB_DIR="$XDATA_PUBLIC_Z3"
export JAVA_CLASSPATH="$CLASSPATH"

echo "=================================================================="
echo "Running XDataPublic Benchmark for Beaver (dw schema)"
echo "Postgres port: $PG_PORT"
echo "Python interpreter: $PYTHON_EXEC"
echo "=================================================================="

"$PYTHON_EXEC" "$DIR/test_beaver_xdata.py" --tool xdatapublic "$@"
