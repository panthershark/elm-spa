const express = require('express');

module.exports = () => {
  const api = express.Router();

  api.get('/current', [
    (req, res, next) => {
      if (!req.user.logged_in) {
        res.json({
          person: null
        });

        return;
      }

      res.json({
        person: req.user.person
      });
    }
  ]);

  return api;
};
