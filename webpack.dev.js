const merge = require('webpack-merge');
const common = require('./webpack.common.js');
const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CleanTerminalPlugin = require('clean-terminal-webpack-plugin');

const HOST = '0.0.0.0';
const PORT = 8080;

module.exports = merge(common, {
    mode: 'development',
    output: {
        filename: "index.bundle.js",
        publicPath: '/',
        path: path.resolve(__dirname, 'public')
    },

    module: {
        rules: [
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    { loader: 'elm-hot-webpack-loader' },
                    {
                        loader: 'elm-webpack-loader',
                        options: {
                            debug: true,
                            verbose: true,
                            forceWatch: true,
                        }
                    }
                ]
            },
            {
                test: /\.css$/,
                use: [
                    "style-loader",
                    "css-loader",
                    "postcss-loader",
                ],
            },
            {
                test: /\.s(a|c)ss$/,
                exclude: [/elm-stuff/, /node_modules/],
                // see https://github.com/webpack-contrib/css-loader#url
                // loaders: ["style-loader", "css-loader?url=false", "sass-loader"]
                use: [
                    "style-loader",
                    "css-loader",
                    "sass-loader"
                ],
            },
        ]
    },
    devServer: {
        host: '0.0.0.0',
        disableHostCheck: true,
        inline: true,
        stats: "errors-only",
        contentBase: path.join(__dirname, "public"),
        historyApiFallback: true,
        overlay: true,
        hot: true
    },
    devtool: 'inline-source-map',
    plugins: [
        new webpack.DefinePlugin({
            ENV: '"Development mode!"',
        }),
        // Optional for terminal cleaning
        // https://www.npmjs.com/package/clean-terminal-webpack-plugin
        new CleanTerminalPlugin({
            //:  This ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ space is important
            message: `                 Dev server running on http://${HOST}:${PORT}`,
            beforeCompile: true
        })

    ]
})

