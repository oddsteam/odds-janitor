.PHONY: up down e2e-ci e2e migrate run test cov mt lint

up: 
	docker-compose -f docker-compose.yml up -d

down:
	docker-compose -f docker-compose.yml down

e2e-ci: mt
	bundle exec cucumber --publish-quiet --tags "not @doing"

e2e: mt
	bundle exec cucumber --publish-quiet

mt:
	RAILS_ENV=test bundle exec rake db:drop db:create db:migrate

migrate: bundle
	rails db:migrate

bundle: 
	bundle install

run: 
	./bin/dev

test:
	bundle exec rspec

cov:
	open coverage/index.html

lint:
	bundle exec brakeman