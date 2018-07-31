'use strict';

// Require assets so they get copied to dist
require('./index.html');
require('./home.svg');
require('./reset.css');
require('./global.css');

var Elm = require('./../Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);
