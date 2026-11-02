#!/usr/bin/env bash
# Manage the LASSO Research & Evaluation Web Server (web/server.py)

CONTAINER_NAME="lasso-analysis-server"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
IP_ADDR=$(ip -4 addr show enp34s0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
if [ -z "$IP_ADDR" ]; then
  IP_ADDR=$(hostname -I | awk '{print $1}')
fi

DOCKER_IMAGE="python:3-alpine"
if docker image inspect sql-execution-tester-execution-tester-api:latest >/dev/null 2>&1; then
  DOCKER_IMAGE="sql-execution-tester-execution-tester-api:latest"
fi

start_container() {
  if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    CMD_STR=$(docker inspect --format '{{join .Config.Cmd " "}}' "${CONTAINER_NAME}" 2>/dev/null || true)
    IMG_STR=$(docker inspect --format '{{.Config.Image}}' "${CONTAINER_NAME}" 2>/dev/null || true)
    if [[ "$CMD_STR" == *"serve_reports.py"* ]] || [[ "$IMG_STR" != "$DOCKER_IMAGE" ]]; then
      echo "Updating container ${CONTAINER_NAME} (${DOCKER_IMAGE})..."
      docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
    fi
  fi

  if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Starting existing container ${CONTAINER_NAME}..."
    docker start "${CONTAINER_NAME}"
  else
    echo "Launching ${CONTAINER_NAME} (web/server.py on ${DOCKER_IMAGE}) on port 80 and 8000..."
    docker run -d \
      --name "${CONTAINER_NAME}" \
      --restart unless-stopped \
      -v "${REPO_DIR}:/repo:ro" \
      -e EXPERIMENTS_DIR=/repo/experiments \
      -e PYTHONPATH=/repo/venv/lib/python3.10/site-packages:/repo/src:/repo/sql-execution-tester \
      -e PORT=8000 \
      -p 80:8000 \
      -p 8000:8000 \
      "${DOCKER_IMAGE}" \
      python3 /repo/web/server.py
  fi
}

case "$1" in
  start)
    start_container
    echo "Server running!"
    echo "  - Research Home: http://${IP_ADDR}/ (or http://localhost:8000/)"
    echo "  - Results Page:  http://${IP_ADDR}/results (or http://localhost:8000/results)"
    ;;
  stop)
    echo "Stopping ${CONTAINER_NAME}..."
    docker stop "${CONTAINER_NAME}"
    ;;
  restart)
    echo "Restarting ${CONTAINER_NAME}..."
    docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
    start_container
    echo "Server running at http://${IP_ADDR}/ and http://${IP_ADDR}/results"
    ;;
  status)
    echo "=== Container Status ==="
    docker ps -f "name=${CONTAINER_NAME}"
    echo ""
    echo "Server URLs:"
    echo "  - Research Home: http://${IP_ADDR}/"
    echo "  - Results Page:  http://${IP_ADDR}/results"
    echo "  - Direct Port:   http://${IP_ADDR}:8000/results"
    ;;
  logs)
    docker logs -f --tail 50 "${CONTAINER_NAME}"
    ;;
  *)
    echo "Usage: $0 {status|start|stop|restart|logs}"
    exit 1
    ;;
esac
