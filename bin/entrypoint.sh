#! bin/sh -e

: "${RUN_SERVER:="true"}"

# Verifica o valor de RUN_SERVER e executa o comando apropriado
if [ "$RUN_SERVER" != "true" ]; then
  echo "Server skipped, keeping container open"
  tail -f /dev/null
else
  echo "Starting server..."
  sh bin/server.sh
fi