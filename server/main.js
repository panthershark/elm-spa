const cookieParser = require('cookie-parser');
const api = require('./api/index');
const demo = require('./middleware/demo.js');

module.exports = (publicPath, server) => {
  server.disable('x-powered-by');

  // authenticate user
  server.use(cookieParser());

  server.use(`${publicPath}/api`, api());

  // boilerplate so the avatar returns
  server.use(demo(publicPath));

  return server;
};
