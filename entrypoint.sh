#!/bin/bash

APP_PORT=8000

# Start main process
echo "Starting application on port $APP_PORT..."
php -S 0.0.0.0:$APP_PORT

exec "$@"
