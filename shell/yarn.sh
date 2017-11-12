#!/usr/bin/env bash

# Install some packages globally with yarn

echo "Installing useful packages globally with yarn"

yarn global add create-react-app
echo "create-react-app installed. Check usage: https://github.com/facebookincubator/create-react-app#creating-an-app"

yarn global add gulp

yarn global add n

yarn add global gify
echo "gify installed. Check usage: https://github.com/tj/node-gify#example"

yarn add global flamegraph
echo "flamegraph installed. Check usage: https://github.com/thlorenz/flamegraph"

yarn add global node-inspector
echo "note-inspector installed. To use run: `node-debug app.js`"

sleep 1

echo "Installing some useful command line interface tools or CLI tools..."

yarn global add uber-cli
echo "uber-cli installed lol. Check usage: https://github.com/jaebradley/uber-cli#usage"

yarn global add pageres-cli
echo "pageres-cli installed. Check usage: https://github.com/sindresorhus/pageres-cli#usage"

yarn global add mklicense
echo "mklicense installed. Check usage: https://github.com/cezaraugusto/mklicense#install"

yarn add global idea
echo "idea installed. Check usage: https://github.com/IonicaBizau/idea#cloud-installation"

yarn add global organize-cli
echo "organize-cli installed. Check usage: https://github.com/ManrajGrover/organize-cli#installation"

yarn add global cli-github
echo "cli-github installed. Check usage: https://github.com/IonicaBizau/cli-github#usage"

yarn add global git-standup
echo "git-standup installed. Check usage: https://github.com/kamranahmedse/git-standup#usage"

yarn add global gistup
echo "gistup installed. Check usage: https://github.com/mbostock/gistup#usage"




echo "...done installing yarn packages"
