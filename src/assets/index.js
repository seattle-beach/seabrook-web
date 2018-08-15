'use strict';

// Require assets so they get copied to dist
require('./index.html');
require('./home.svg');
require('./pencil.svg');
require('./reset.css');
require('./global.css');

var Elm = require('./../Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode, {
  apiUri: process.env.API_URI
});
