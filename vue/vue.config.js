const { defineConfig } = require("@vue/cli-service");

module.exports = defineConfig({
    transpileDependencies: true,
    chainWebpack: config => {
        config.optimization.splitChunks(false);
        config.output.filename('[name].js');
    },
    css: {
        extract: {
            filename: '[name].css',
            chunkFilename: '[name].css',
        },
    },
});
