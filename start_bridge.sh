#!/bin/bash

# Configuration
PROJECT_DIR="/usr/bin/mine/G_E_Bridge"
# Changed the port to 026524
PORT=26524
TOOL_NAME="G_E_Bridge"

# --- Main Logic ---

# Find all processes listening on the port
SERVER_PIDS=$(lsof -ti tcp:$PORT)

if [ -n "$SERVER_PIDS" ]; then
    # Server is running → stop all processes on the port
    echo "Server is already running on port $PORT (PIDs: $SERVER_PIDS). Stopping..."
    kill -TERM $SERVER_PIDS 2>/dev/null
    sleep 1
    # If still running, force kill
    SERVER_PIDS=$(lsof -ti tcp:$PORT)
    if [ -n "$SERVER_PIDS" ]; then
        echo "Server did not stop gracefully, force killing..."
        kill -KILL $SERVER_PIDS 2>/dev/null
    fi
    notify-send "$TOOL_NAME stopped" "Server on port $PORT has been stopped."
    exit 0
else
    # Server is not running → start it
    cd "$PROJECT_DIR" || { echo "Project directory not found!"; exit 1; }

    # Start the server in the background
    nohup python3 -m http.server "$PORT" >/dev/null 2>&1 &
    
    sleep 1 # give server a moment to start
    
    notify-send "$TOOL_NAME started" "Server running at http://localhost:$PORT"
    
    # Open URL in default browser (removed the trailing & for reliability)
    xdg-open "http://localhost:$PORT" >/dev/null 2>&1

    # Wait for server to run until script is terminated
    echo "Server running on port $PORT. Press Ctrl+C to stop..."
    SERVER_PID=$!
    wait "$SERVER_PID"
fi
