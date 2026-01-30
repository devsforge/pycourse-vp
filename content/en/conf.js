/**
 * Webpack entry point
 */

// add JS modules
// todo: GH-211

// add stylesheets to webpack bundle
// todo: GH-211

// add assets/resources to webpack bundle
import "../assets/icons/check-mark-svgrepo-com.svg"
import "../assets/icons/cross-mark-svgrepo-com.svg"
import "../assets/icons/moon-svgrepo-com.svg"
import "../assets/icons/sun-svgrepo-com.svg"

// import and initialize impress.js presentation framework
import "../assets/impress.js/js/impress"
import "../assets/impress.js/css/impress-common.css"

impress().init()
