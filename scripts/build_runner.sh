#!/usr/bin/env bash

if [ "$(basename "$PWD")" = 'scripts' ]; then cd ..; fi

flutter pub get &&
  dart run build_runner watch --delete-conflicting-outputs