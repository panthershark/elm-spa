const express = require('express');
const authenticate = require('../middleware/authenticate.js');

const api_headers = (req, res, next) => {
  res.set({
    'Cache-Control': 'no-cache, no-store, must-revalidate',
    Expires: 0,
    Pragma: 'no-cache',
    'X-Powered-By': 'tacos'
  });

  next();
};

module.exports = () => {
  const api = express();

  api.use(api_headers);

  api.use('/user', [ authenticate, require('./services/user.js')() ]);

  api.all('*', (req, res, next) => {
    res.status(404).json({
      success: false,
      message: 'api not found'
    });
  });

  api.use(function(err, req, res, next) {
    console.log(err);
    next(err);
  });

  return api;
};
