module.exports = (req, res, next) => {
  req.user = {
    logged_in: true,
    person: {
      id: 'p0',
      first_name: 'Bob',
      last_name: 'Marley'
    }
  };

  next();
};
