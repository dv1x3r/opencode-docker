#!/bin/bash
set -e

NAME="$(basename "$(pwd)")"

VOLUMES=(
    -v "$HOME/.local/state/opencode:/home/node/.local/state/opencode"
    -v "$HOME/.local/share/opencode:/home/node/.local/share/opencode"
    -v "$HOME/.config/opencode:/home/node/.config/opencode"
    -v "$(pwd):/app/$NAME:rw"
)

DEFAULT_PORT=4096
MAX_PORT=4196

is_port_free() {
    ! lsof -iTCP:$1 -sTCP:LISTEN >/dev/null 2>&1
}

if [[ "${1:-}" == "web" ]]; then
    PORT=$DEFAULT_PORT
    while ! is_port_free $PORT; do
        PORT=$((PORT + 1))
        if (( PORT > MAX_PORT )); then
            echo "No free ports $DEFAULT_PORT-$MAX_PORT"
            exit 1
        fi
    done
    docker run --rm -it \
        --name "opencode-${NAME}" \
        -w "/app/$NAME" \
        "${VOLUMES[@]}" \
        -p $PORT:$PORT \
        opencode-ai "$@" --port $PORT --hostname 0.0.0.0
else
    docker run --rm -it \
        --name "opencode-${NAME}" \
        -w "/app/$NAME" \
        "${VOLUMES[@]}" \
        opencode-ai "$@"
fi

