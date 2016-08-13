export default {
  database: process.env.MONGO_URI || 'localhost/hing',
  port: process.env.PORT || 3000,
  env: process.env.NODE_ENV || 'development',
  logLevel: process.env.NODE_ENV === 'development' ? 'debug' : 'info',
  logFile: process.env.LOGFILE || '../logs/' + process.env.NODE_ENV + '.log'
};
