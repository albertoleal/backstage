#!/bin/bash
mongod &
redis-server &

/opt/go/src/github.com/backstage/backstage/httpserver
