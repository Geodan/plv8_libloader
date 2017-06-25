# plv8_libloader

For loading javascript libraries into PostgreSQL
This script will load a couple of hand-picked libraries into your postgres database to use them with plv8
At the moment the following libraries are included (also see package.json):
* d3: "^4.7.4",
* d3-contour: "^1.1.0",
* d3-force: "^1.0.6",
* d3-geo: "^1.6.3",
* d3-hexbin: "^0.2.2",
* delaunator: "git+https://github.com/tomvantilburg/delaunator.git",
* geotiff: "^0.4.1",
* topojson": "^3.0.0"


## Prerequisites


PostgreSQL 6.4 with PL/v8 2.0.3 

note: PL/v8 2.0.3 packages not available yet, requires manual build
See the instructions over here: 
https://github.com/plv8/plv8/blob/master/doc/plv8.md#installing-plv8
(make sure to use `make static` in order to get the latest v8 engine)

## Installing

```
$ git clone https://github.com/Geodan/plv8_libloader.git
$ cd plv8_libloader
$ npm install 
$ npm run build
$ psql -d <yourdb> -f loader.sql
```

What it does is downloading the packages from npm (npm install) and preparing some packages for loading as a global (npm run build)
Last step is loading all the js into a table from the loader.sql script and running a short test to see if it loads in plv8.