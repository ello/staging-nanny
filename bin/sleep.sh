#!/bin/bash

# terminate script as soon as any command fails
set -eux


if [[ -z "$APP" ]]; then
  echo "Missing APP variable which must be set to the name of the Heroku app you would like to wake up"
  exit 1
fi

echo "Putting $APP's dynos to sleep..."
echo "For the record, I'm only telling the following dyno types to go to sleep:
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
heroku ps:scale asset_worker=0 --app $APP
heroku ps:scale critical_worker=0 --app $APP
heroku ps:scale default_worker=0 --app $APP
heroku ps:scale deletion_worker=0 --app $APP
heroku ps:scale elasticsearch_index_worker=0 --app $APP
heroku ps:scale email_worker=0 --app $APP
heroku ps:scale fanout_high_worker=0 --app $APP
heroku ps:scale fanout_low_worker=0 --app $APP
heroku ps:scale fanout_post_worker=0 --app $APP
heroku ps:scale fanout_worker=0 --app $APP
heroku ps:scale low_worker=0 --app $APP
heroku ps:scale mailchimp_worker=0 --app $APP
