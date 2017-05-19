// rollup.config.js
import commonjs from 'rollup-plugin-commonjs';
import resolve from 'rollup-plugin-node-resolve';

export default {
  entry: 'src/geotiff.js',
  format: 'umd',
  moduleName: 'GeoTIFF',
  plugins: [ resolve(),
  	commonjs({
  			namedExports: { './geotiff.js': ['parse'] }
  })],
  dest: 'libraries/geotiff.js'
};

