require('dotenv').config({
  path: process.env.DOTENV
});

const webpack = require('webpack');
const config = require('../webpack.dev.config.js');
const express = require('express');
const main = require('../server/main.js');
const path = require('path');
const server = express();
const compiler = webpack(config);
const { publicPath } = config.output;

server.use(
  require('webpack-dev-middleware')(compiler, {
    publicPath,
    contentBase: './src',
    hot: true,
    quiet: false,
    noInfo: false,
    lazy: false,
    watch: true,
    stats: {
      chunks: false,
      chunkModules: false,
      colors: true
    }
  })
);

const hmr_path = `${publicPath}_hmr/__webpack_hmr`;

console.log(`HMR connecting at ${hmr_path}`);
server.use(
  require('webpack-hot-middleware')(compiler, {
    path: hmr_path
  })
);

const dev_server_lag = parseInt(process.env.DEV_SERVER_LAG, 10);

if (!isNaN(dev_server_lag)) {
  server.use((req, res, next) => {
    setTimeout(next, dev_server_lag);
  });
}

main(publicPath, server);

server.get('*', [
  function(req, res, next) {
    const filename = path.join(compiler.outputPath, 'index.html');

    compiler.outputFileSystem.readFile(filename, (err, result) => {
      if (err) {
        return next(err);
      }
      res.set('content-type', 'text/html');
      res.send(result);
      res.end();
    });
  }
]);

server.use(function(err, req, res, next) {
  const status_code = isNaN(err.status_code) ? 500 : Number(err.status_code);
  res.status(status_code).send(err.stack);
});

server.listen(process.env.PORT);
console.log(`App server is now running at http://localhost:${process.env.PORT}.`);
