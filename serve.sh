#!/bin/bash
pkill -f "jekyll serve" 2>/dev/null
bundle exec jekyll serve
