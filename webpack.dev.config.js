var path = require('path');
var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer = require('autoprefixer');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var entryPath = path.join(__dirname, 'src/static/index.js');
var outputPath = path.join(__dirname, 'dist');
const cssnano = require('cssnano');
const publicPath = '/elm-spa';
const hmr_path = `${publicPath}_hmr/__webpack_hmr`;

module.exports = {
  mode: 'development',
  entry: [ `webpack-hot-middleware/client?path=${hmr_path}`, entryPath ],

  output: {
    path: outputPath,
    filename: `./static/[name].js`,
    publicPath
  },

  resolve: {
    extensions: [ '.js', '.elm' ]
  },

  module: {
    noParse: /\.elm$/,
    rules: [
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      },
      {
        test: /\.elm$/,
        exclude: [ /elm-stuff/, /node_modules/ ],
        use: [
          {
            loader: 'elm-hot-loader',
            options: {}
          },
          {
            loader: 'elm-webpack-loader',
            options: {
              debug: true,
              forceWatch: true
            }
          }
        ]
      },
      {
        test: /\.(css|scss)$/,
        use: [
          {
            loader: 'style-loader'
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'postcss-loader',
            options: {
              plugins: function() {
                return [
                  cssnano({
                    autoprefixer: {
                      add: true,
                      remove: true,
                      browsers: [ 'last 2 versions' ]
                    },
                    discardComments: {
                      removeAll: true
                    },
                    discardUnused: false,
                    mergeIdents: false,
                    reduceIdents: false,
                    safe: true,
                    sourcemap: false
                  })
                ];
              }
            }
          },
          {
            loader: 'sass-loader',
            options: {
              includePaths: [ path.resolve('./src/static', './styles'), path.resolve('./node_modules') ]
            }
          }
        ]
      }
    ]
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/static/index.html',
      inject: 'body',
      filename: 'index.html',
      minify: {
        collapseWhitespace: true
      }
    }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoEmitOnErrorsPlugin()
  ]
};
