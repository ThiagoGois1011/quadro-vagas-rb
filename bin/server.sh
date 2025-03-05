#! bin/sh -e

bin/rails db:prepare
rm -f tmp/pids/server.pid
exec bin/dev