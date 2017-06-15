# plv8_libloader
For loading javascript libraries into PostgreSQL


Preprequisites:

Postgresql 6.4 with plv8 2.0.3 
note: plv8 2.0.3 packages not available yet, requires manual built

Installing

```
$ git clone https://github.com/Geodan/plv8_libloader.git
$ cd plv8_libloader
$ npm install 
$ npm run build
$ psql -d <yourdb> -U postgres -f d3.sql
```
