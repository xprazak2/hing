'use strict';

var path = require('path');
var webpack = require('webpack');
// var ExtractTextPlugin = require('extract-text-webpack-plugin');
// var htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  devtool: 'inline-source-map',
  entry: [
    'webpack-hot-middleware/client?reload=true',
    path.join(__dirname, 'app/main.js')
  ],
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js',
    publicPath: '/'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: [/node_modules/],
        loader: 'babel-loader',
        query: {
          "presets": ["react", "es2015", "react-hmre"]
        }
      },
      {
        test: /\.scss$/,
        loader: ['style-loader', 'css-loader?sourceMap']
        // maybe will be needed for production
        // loader: ExtractTextPlugin.extract('css-loader!sass-loader')
      }
    ]
  },
  plugins: [
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    // new ExtractTextPlugin({ filename: 'main.css', allChunks: true })
  ]
};
