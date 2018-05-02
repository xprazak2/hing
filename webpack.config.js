'use strict';

var path = require('path');
var webpack = require('webpack');
// var ExtractTextPlugin = require('extract-text-webpack-plugin');
// var htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: './app/elm.js',
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js'
    // publicPath: '/'
  },
  resolve: {
    modules: [path.join(__dirname, "app"), "node_modules"],
    extensions: [".js", ".elm", ".scss", ".png"]
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: ['style-loader', 'css-loader?sourceMap', 'sass-loader?sourceMap']
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: 'elm-hot-loader'
          },
          {
            loader: "elm-webpack-loader",
            options: {
              debug: true,
              forceWatch: true
            }
          }
        ]
      }
    ]
  },
  devServer: {
    inline: true,
    stats: "errors-only",
    historyApiFallback: true
  },
  plugins: [
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.NamedModulesPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    // new ExtractTextPlugin({ filename: 'main.css', allChunks: true })
  ]
};
