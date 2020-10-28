# Kasaz(Test Project) Ruby on Rails + GraphQL Backend (API only)

* Main tech stacks

     Ruby on Rails, GraphQL, PostgreSQL, RSpec

* Versions

     ruby '2.6.6'

     rails '~> 6.0.3', '>= 6.0.3.2'

* Setup environment

     `bundle install`

* Database setup

     `rails db:create db:migrate db:seed`

* Running backend on local

     `rails s`

* Running unit test

     `rails test`

## Docker Development

Install docker and docker-compose. To start, restart your docker api stack.
Copy the dev docker file to the default. We do this as you may want to have changes
in your environment that you may not want to accidentally commit.

    cp docker-compose.dev.yml docker-compose.yml

To start, restart your docker api stack. If you don't copy the file above you will
have to use the ```-f <filename>``` flag.

    docker-compose up -d --force-recreate

Re-Bundle gems within the api image

    docker-compose up -d --build

DB Create / Migrate / Seed.  Each can be run separately.

    docker-compose run api rake db:create db:migrate db:seed
