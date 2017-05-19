// rollup.config.js
import commonjs from 'rollup-plugin-commonjs';
import resolve from 'rollup-plugin-node-resolve';

export default {
  entry: 'src/delaunator.js',
  format: 'umd',
  moduleName: 'Delaunator',
  plugins: [ resolve(),
  	commonjs(
  		{
  		namedExports: { './delaunator.js': ['Delaunator'] }
  } 
  )],
  dest: 'libraries/delaunator.js'
};

