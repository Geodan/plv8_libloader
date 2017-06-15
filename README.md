# plv8_libloader

For loading javascript libraries into PostgreSQL

## Prerequisites

PostgreSQL 6.4 with PL/v8 2.0.3 
note: PL/v8 2.0.3 packages not available yet, requires manual build

## Installing

```
$ git clone https://github.com/Geodan/plv8_libloader.git
$ cd plv8_libloader
$ npm install 
$ npm run build
$ psql -d <yourdb> -U postgres -f d3.sql
```
