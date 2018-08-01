const path = require('path');

const Dotenv = require('dotenv-webpack');

module.exports = {
  entry: {
    app: [
      './src/assets/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  plugins: [
    new Dotenv({systemvars: true})
  ],

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test:    /\.(html|svg)$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
    ],

    noParse: /\.elm$/,
  },
};
