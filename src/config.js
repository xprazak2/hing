export default {
  database: process.env.MONGO_URI || 'localhost/hing',
  port: process.env.PORT || 3000
};
