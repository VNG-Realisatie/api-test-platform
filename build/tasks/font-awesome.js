const fs = require('fs');
const log = require('fancy-log');
const gulp = require('gulp');
const paths = require('../paths');
const argv = require('yargs').argv;


/**
 * Font Awesome task
 * Run using "gulp font-awesome"
 * Moves Font Awesome font files to paths.fontDir
 */
gulp.task('font-awesome', () => {
    fs.stat('node_modules/font-awesome/fonts', e => {
        if (e && argv._.indexOf('font-awesome') > -1) {
            log.info('Not copying Font Awesome as it\'s not installed...');
            return;
        }

        return gulp.src('node_modules/font-awesome/fonts/*')
            .pipe(gulp.dest(paths.fontsDir));
    });
});
