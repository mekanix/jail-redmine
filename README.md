# jail-redmine

Redmine in FreeBSD jail

PostgreSQL setup

```
CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'redmine' NOINHERIT VALID UNTIL 'infinity';
CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine;
```

Redmine setup

```
cd /usr/local/www/redmine
bundle exec rake generate_secret_token
env RAILS_ENV=production bundle exec rake db:migrate
env RAILS_ENV=production bundle exec rake redmine:load_default_data
service redmine restart
```
