#! bin/sh -e
bin/rails db:create
bin/rails db:migrate
foreman start -f Procfile.dev