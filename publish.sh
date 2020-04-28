#!/bin/sh

eval opam env

netlify deploy --prod --dir "$(odig cache path)"/html
