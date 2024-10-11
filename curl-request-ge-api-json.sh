#!/bin/sh

curl http://api.example.com:81 -d '{"cityQuery": "south bo"}' -H "SOAPAction:findCity" -H "content-type:application/json" | jq
