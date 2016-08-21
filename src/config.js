function inEnv(env) {
  return process.env.NODE_ENV === env;
}

export default {
  database: process.env.MONGO_URI || (inEnv('test') ? 'localhost/hing-test' : 'localhost/hing'),
  port: process.env.PORT || 3000,
  env: process.env.NODE_ENV || 'development',
  logLevel: process.env.LOG_LEVEL || (inEnv('development') ? 'debug' : 'info'),
  logFile: process.env.LOG_FILE || '../logs/' + process.env.NODE_ENV + '.log'
};
