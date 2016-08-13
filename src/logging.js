import winston from 'winston';
import config from './config';
import expressWinston from 'express-winston';

const createConsoleTransport = (opts) => {
  return new winston.transports.Console(opts);
};

const createFileTransport = (opts) => {
  return new winston.transports.File(opts);
};

// common logger opts
let transports = [];
let consoleOpts = { colorize: true, timestamp: true };
let fileOpts = { colorize: false, timestamp: true, filename: config.logFile };

// do we want to log in json format?
// consoleOpts.json = true;
const inDevelopment = () => {
  return config.env === 'development';
};

// configure transports based on env
if (inDevelopment()) {
  transports.push(createConsoleTransport(consoleOpts));
} else {
  transports.push(createFileTransport(fileOpts));
}

// create logger
export const logger = new winston.Logger({
  transports: transports,
  level: config.logLevel
});

// create express logger
export const expressLogger = expressWinston.logger({
  winstonInstance: logger,
  meta: false,
  expressFormat: true,
  colorize: inDevelopment()
});

// create express error logger - TODO
export const expressErrorLogger = expressWinston.errorLogger({
  winstonInstance: logger
});
