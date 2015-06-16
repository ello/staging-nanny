#!/bin/bash

# terminate script as soon as any command fails
set -eux


if [[ -z "$APP" ]]; then
  echo "Missing APP variable which must be set to the name of the Heroku app you would like to wake up"
  exit 1
fi

echo "Waking up $APP's dynos..."
echo "For the record, I'm only telling the following dyno types to wake up, and I'm only turning on one instance:
- asset_worker
- critical_worker
- default_worker
- deletion_worker
- elasticsearch_index_worker
- email_worker
- fanout_high_worker
- fanout_low_worker
- fanout_post_worker
- fanout_worker
- low_worker
- mailchimp_worker"

# BRUTE FORCE!  ENGAGE!
heroku ps:scale asset_worker=1 --app $APP
heroku ps:scale critical_worker=1 --app $APP
heroku ps:scale default_worker=1 --app $APP
heroku ps:scale deletion_worker=1 --app $APP
heroku ps:scale elasticsearch_index_worker=1 --app $APP
heroku ps:scale email_worker=1 --app $APP
heroku ps:scale fanout_high_worker=1 --app $APP
heroku ps:scale fanout_low_worker=1 --app $APP
heroku ps:scale fanout_post_worker=1 --app $APP
heroku ps:scale fanout_worker=1 --app $APP
heroku ps:scale low_worker=1 --app $APP
heroku ps:scale mailchimp_worker=1 --app $APP
