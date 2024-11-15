#!/bin/bash

# Print environment for debugging
echo "Current directory: $(pwd)"
echo "Python path: $PYTHONPATH"
echo "Contents of current directory:"
ls -la

# Start the application
python -m uvicorn cookbook.assistants.tools.app:app --host 0.0.0.0 --port 7777 --log-level debug
