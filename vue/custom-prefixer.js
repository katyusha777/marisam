const postcss = require('postcss');

module.exports = postcss.plugin('custom-prefixer', function() {
    return function(css) {
        css.walkRules((rule) => {
            if (rule.selector.startsWith('.'))
                rule.selector = `#vueApp ${rule.selector}`;
        });
    };
});
