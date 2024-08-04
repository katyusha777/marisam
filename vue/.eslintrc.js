module.exports = {
  root: true,
  env: {
    node: true
  },
  'extends': [
    'plugin:vue/vue3-essential',
    'eslint:recommended',
    '@vue/typescript/recommended'
  ],
  parserOptions: {
    ecmaVersion: 2020
  },
  rules: {
    '@typescript-eslint/no-inferrable-types': 'off',
    '@typescript-eslint/ban-ts-comment': 'off',
    '@typescript-eslint/no-explicit-any': 'off',
    'vue/valid-v-for': 'off',
    'no-undef': 'off',
    'no-shadow-restricted-names': 'off',
    'no-prototype-builtins': 'off',
    'no-useless-escape': 'off',
    '@typescript-eslint/no-this-alias': 'off',
    'no-constant-condition': 'off',
    'no-cond-assign': 'off',
    '@typescript-eslint/no-empty-function': 'off',
    'vue/no-setup-props-destructure': 'off',
    'vue/require-v-for-key': 'off',
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off'
  }
}
