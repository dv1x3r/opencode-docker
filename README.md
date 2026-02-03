# OpenCode in Docker

Docker container setup for running [OpenCode CLI](https://opencode.ai) in isolated environments.

- Isolated environment with Node.js, Python, and Go.
- Mounts your current project directory into the container.
- Persists OpenCode configuration and state.
- Automatic port detection for web mode (4096-4196).
- Runs as non-root user for security.

## Setup

### 1. Build the Docker image

```bash
./build.sh
```

### 2. Install the script

```bash
cp ./opencode.sh ~/.local/bin/opencode
chmod +x ~/.local/bin/opencode
```

## Usage

### Run in TUI mode

```bash
opencode
```

### Run in Web mode

```bash
opencode web
```
