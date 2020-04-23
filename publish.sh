#!/bin/sh

netlify deploy --prod "$(odig cache path)"/html
