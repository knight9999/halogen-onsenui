var path = require('path');
var PulpWebpackPlugin = require('pulp-webpack-plugin');
var HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = [{
  mode: 'development',
  entry: path.resolve(__dirname, 'src', 'js', 'index.js'),
  output: { path: path.resolve(__dirname, 'public'), filename: 'bundle.js' },
  module: {
    rules: [
      {
        test: /\.js?$/
      },
      {
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url-loader'
      },
      {
        test: /\.(mp4|webm|ogg|mp3|wav|flac|aac)(\?.*)?$/,
        loader: 'url-loader'
      },
      {
        test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
        loader: 'url-loader'
      },
      {
        test: /\.css$/,
        use: [{
          loader: 'style-loader'
        }, {
          loader: 'css-loader'
        }]
      },
      {
        test: /\.html$/,
        loader: "html-loader"
      }
    ]
  },

  resolve: {
    extensions: ['.js'],
    alias: {
      App: path.resolve(__dirname, 'work', 'build')
    }
  },

  devtool: 'source-map',
  
  plugins: [
    new PulpWebpackPlugin({
      'pulp': 'node_modules/.bin/pulp',
      'build': 'browserify',
      'build-path' : './work/output',
      'standalone': 'app',
      'src-path': 'src/ps',
      'main': 'Main',
      'to': 'work/build/app.js'
    }),
    new HtmlWebpackPlugin({
      template: "src/html/index.html"
    })
  ]
}]