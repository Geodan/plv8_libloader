\set d3 `cat ./node_modules/d3/build/d3.min.js`
\set d3_hexbin `cat ./node_modules/d3-hexbin/build/d3-hexbin.min.js`
\set d3_contour `cat ./node_modules/d3-contour/build/d3-contour.min.js`
\set d3_geo `cat ./node_modules/d3-geo/build/d3-geo.min.js`

\set topojson `cat ./node_modules/topojson/dist/topojson.min.js`
\set delaunator `cat ./libraries/delaunator.js`
\set geotiff `cat ./libraries/geotiff.js`
--\set geotiff `cat ./node_modules/geotiff/dist/geotiff.browserify.js`

/******************************************************************************
Now that we have set variables containing the code
we need to create a table to store each of them in
postgres. 
******************************************************************************/
create table IF NOT EXISTS plv8_modules(modname text primary key, load_on_start boolean, code text);

insert into plv8_modules values ('d3',true,:'d3') ON CONFLICT (modname) DO UPDATE SET code = :'d3' WHERE plv8_modules.modname = 'd3';
insert into plv8_modules values ('d3_geo',true,:'d3_geo') ON CONFLICT (modname) DO UPDATE SET code = :'d3_geo' WHERE plv8_modules.modname = 'd3_geo';
insert into plv8_modules values ('d3_contour',true,:'d3_contour') ON CONFLICT (modname) DO UPDATE SET code = :'d3_contour' WHERE plv8_modules.modname = 'd3_contour';
insert into plv8_modules values ('d3_hexbin',true,:'d3_hexbin') ON CONFLICT (modname) DO UPDATE SET code = :'d3_hexbin' WHERE plv8_modules.modname = 'd3_hexbin';
insert into plv8_modules values ('topojson',true,:'topojson') ON CONFLICT (modname) DO UPDATE SET code = :'topojson' WHERE plv8_modules.modname = 'topojson';
insert into plv8_modules values ('geotiff',true,:'geotiff') ON CONFLICT (modname) DO UPDATE SET code = :'geotiff' WHERE plv8_modules.modname = 'geotiff';
insert into plv8_modules values ('delaunator',true,:'delaunator') ON CONFLICT (modname) DO UPDATE SET code = :'delaunator' WHERE plv8_modules.modname = 'delaunator';



/******************************************************************************
Create a a startup function to create a plv8 function
that will be used to load the modules, Executing it 
will register the plv8 function
******************************************************************************/

create or replace function plv8_startup()
returns void
language plv8
as
$$
load_module = function(modname) {
  var rows = plv8.execute("SELECT code from plv8_modules " +" where modname = $1", [modname]);
  for (var r = 0; r < rows.length; r++) {
    var code = rows[r].code;
    eval("(function() { " + code + "})")();
  }      
};
$$;

select plv8_startup(); 


/******************************************************************************
Load both modules into postgres using the previously created plv8 function
******************************************************************************/
do language plv8 ' load_module("topojson"); ';
do language plv8 $$
	var topo = topojson.topology({entities: {
		type: 'Feature',
		geometry: {
			type: 'Point',
			coordinates: [0,0]
		}
	}},1);
$$;


do language plv8 ' load_module("geotiff"); ';
do language plv8 $$
	plv8.elog(NOTICE,'Geotiff is a typeof: ',typeof Geotiff);
$$;
do language plv8 ' load_module("delaunator"); ';
do language plv8 $$
	plv8.elog(NOTICE,'Delaunator is a typeof: ',typeof Delaunator);
$$;