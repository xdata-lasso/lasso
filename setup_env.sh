#!/bin/bash
set -e

echo "Finding Python 3.10+..."
PYTHON_CMD=""
for cmd in python3.12 python3.11 python3.10 python3 python; do
    if command -v "$cmd" > /dev/null 2>&1; then
        version=$("$cmd" -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")' 2>/dev/null || echo "0.0")
        major=$(echo "$version" | cut -d. -f1)
        minor=$(echo "$version" | cut -d. -f2)
        if [ "$major" -eq 3 ] && [ "$minor" -ge 10 ]; then
            PYTHON_CMD="$cmd"
            break
        fi
    fi
done

if [ -z "$PYTHON_CMD" ]; then
    echo "Error: Python 3.10 or higher is required, but could not be found."
    echo "Please install Python 3.10+ or activate an environment with Python 3.10+."
    exit 1
fi

echo "Using $PYTHON_CMD ($version)"
echo "Setting up virtual environment..."
$PYTHON_CMD -m venv venv
echo "Activating virtual environment..."
. venv/bin/activate

echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Cloning execution-test-plus dependency..."
if [ ! -d "sql-execution-tester" ]; then
    git clone https://github.com/shreyas-jadhav/execution-test-plus.git sql-execution-tester 2>/dev/null || \
    git clone git@github.com:shreyas-jadhav/execution-test-plus.git sql-execution-tester
else
    echo "sql-execution-tester already exists."
fi

echo "Setup complete! Run 'source venv/bin/activate' to activate the environment."
