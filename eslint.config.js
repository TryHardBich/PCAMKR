// eslint.config.js
import globals from 'globals';
import js from '@eslint/js';

export default [
    js.configs.recommended,
    {
        ignores: [
            '**/node_modules/**',
            '**/dist/**',
            '**/build/**',
            'temp.js'
        ]
    },
    {
        files: ['**/*.js'],
        languageOptions: {
            ecmaVersion: 2022,
            sourceType: 'module',
            globals: {
                ...globals.node,
                ...globals.es2021
            }
        },
        rules: {
            'semi': ['error', 'always'],
            'quotes': ['error', 'single'],
            'no-unused-vars': ['warn'],
            'no-console': ['off']
        }
    }
];