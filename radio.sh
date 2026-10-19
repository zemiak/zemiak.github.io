#!/bin/sh

devbox run -- python3 -m http.server 8000 --directory radio
open localhost:8000
