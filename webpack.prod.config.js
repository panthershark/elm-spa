var path = require('path');
var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
var autoprefixer = require('autoprefixer');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var entryPath = path.join(__dirname, 'src/static/index.js');
var outputPath = path.join(__dirname, 'dist');
const cssnano = require('cssnano');
const publicPath = '/elm-spa';

module.exports = {
  mode: 'production',
  entry: entryPath,

  output: {
    path: outputPath,
    filename: `./static/[name]-[hash].js`,
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
              debug: false,
              forceWatch: false
            }
          }
        ]
      },
      {
        test: /\.(css|scss)$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader
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
                    sourcemap: true
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

  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        cache: false,
        parallel: true,
        sourceMap: false
      }),
      new OptimizeCSSAssetsPlugin({})
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
    new MiniCssExtractPlugin({
      filename: 'static/[name]-[hash].css',
      chunkFilename: '[id].[hash].css'
    }),
    new webpack.NoEmitOnErrorsPlugin()
  ]
};
