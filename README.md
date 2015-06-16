Simple heroku app with a bash script for putting our staging environments to sleep at night.  Deploy this as a separate app within heroku and schedule the script to shut down and start up the dynos.


## Installation


First create a project on heroku with the [heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi).

```
heroku create ello-staging-nanny --buildpack https://github.com/ddollar/heroku-buildpack-multi
```

Next push this project to your heroku projects git repository.

```
heroku git:remote -a ello-staging-nanny
git push heroku master
```

Now we need to set some environment variables in order to get the heroku cli working properly using the [heroku-buildpack-toolbet](We are using the https://github.com/gregburek/heroku-buildpack-toolbelt.git).

```
heroku config:add HEROKU_TOOLBELT_API_EMAIL=your-email@gmail.com -a ello-staging-nanny
heroku config:add HEROKU_TOOLBELT_API_PASSWORD=`heroku auth:token` -a ello-staging-nanny
```

Finally, we need to add heroku scheduler and call [sleep.sh](https://github.com/kbaum/heroku-staging-nanny/blob/master/bin/sleep.sh) and [wake.sh](https://github.com/kbaum/heroku-staging-nanny/blob/master/bin/wake.sh) on regular intervals.

```
heroku addons:add scheduler -a ello-staging-nanny
```

Now open it up, in your browser with:

```
heroku addons:open scheduler -a ello-staging-nanny
```

For every staging environment, create two jobs:  
One to put it to sleep:  

```
APP=your_staging_environment /app/bin/sleep.sh
```

And one to wake it up:  

```
APP=your_staging_environment /app/bin/wake.sh
```

Use the "Daily" schedule option, and note that all times are UTC.
