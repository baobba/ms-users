#!/bin/sh

echo "SECRET_KEY_BASE="`rake secret` >> .userms.env

