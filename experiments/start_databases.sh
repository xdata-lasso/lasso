#!/bin/bash
# start_databases.sh - Robust database starter & health checker for Linux and macOS

if [ -n "$BASH_SOURCE" ]; then
    _START_DB_DIR="${BASH_SOURCE[0]}"
else
    _START_DB_DIR="$0"
fi
BASE_DIR="${DIR:-$( cd "$( dirname "$_START_DB_DIR" )" >/dev/null 2>&1 && pwd )}"
COMPOSE_FILE="$BASE_DIR/../docker-compose.yml"

check_port() {
    local host="127.0.0.1"
    local port="$1"
    local py_cmd="${PYTHON_EXEC:-${PYTHON_CMD:-python3}}"
    if command -v "$py_cmd" >/dev/null 2>&1; then
        "$py_cmd" -c "import socket; s = socket.socket(); s.settimeout(0.5); s.connect(('$host', int('$port'))); s.close()" >/dev/null 2>&1
        return $?
    elif command -v nc >/dev/null 2>&1; then
        nc -z -w 1 "$host" "$port" >/dev/null 2>&1
        return $?
    fi
    return 1
}

echo "Checking database services..."

# If postgres is not yet listening, try to start containers
if ! check_port 54320 && ! check_port 5432; then
    if command -v docker >/dev/null 2>&1; then
        if ! docker info >/dev/null 2>&1; then
            if [ "$(uname -s)" = "Darwin" ] && [ -d "/Applications/Docker.app" ]; then
                echo "Docker daemon is not running. Attempting to start Docker Desktop on macOS (waiting up to 45s)..."
                open -a Docker 2>/dev/null || true
                for i in $(seq 1 45); do
                    if docker info >/dev/null 2>&1; then
                        echo "Docker Desktop started successfully."
                        break
                    fi
                    sleep 1
                done
            elif [ "$(uname -s)" = "Linux" ]; then
                (sudo -n systemctl start docker 2>/dev/null || sudo -n service docker start 2>/dev/null || true)
                for i in $(seq 1 5); do
                    if docker info >/dev/null 2>&1; then
                        break
                    fi
                    sleep 1
                done
            fi
        fi

        if docker info >/dev/null 2>&1 && [ -f "$COMPOSE_FILE" ]; then
            docker compose -f "$COMPOSE_FILE" up -d 2>/dev/null || \
            docker-compose -f "$COMPOSE_FILE" up -d 2>/dev/null || true
        fi
    fi

    # Wait up to 10 seconds for PostgreSQL port
    for i in $(seq 1 10); do
        if check_port 54320 || check_port 5432; then
            break
        fi
        sleep 1
    done
fi

# Set environment variables for ports, with fallback to standard ports if needed
if check_port 54320; then
    export POSTGRES_PORT=54320
elif check_port 5432; then
    export POSTGRES_PORT=5432
    echo "Notice: Using local PostgreSQL on port 5432."
else
    export POSTGRES_PORT=""
    echo "Warning: PostgreSQL is not responding on port 54320 or 5432."
fi

if check_port 33061; then
    export MYSQL_PORT=33061
elif check_port 33060; then
    export MYSQL_PORT=33060
elif check_port 3306; then
    export MYSQL_PORT=3306
    echo "Notice: Using local MySQL on port 3306."
else
    export MYSQL_PORT=""
    echo "Warning: MySQL is not responding on port 33061, 33060 or 3306."
fi

