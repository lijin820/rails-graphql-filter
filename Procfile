web: bundle exec puma -p $PORT -C ./config/puma.rb
worker: bundle exec rails jobs:work
release: bin/rake db:migrate
