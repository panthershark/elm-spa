const express = require('express');

module.exports = (publicPath) => {
  const demo = express.Router();

  demo.get(`${publicPath}/person/avatar/:id`, (req, res, next) => {
    res.redirect('https://api.adorable.io/avatars/100/bob-marley@adorable.io');
  });

  return demo;
};
