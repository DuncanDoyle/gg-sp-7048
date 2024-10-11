#!/bin/sh

curl http://api.example.com -d '{"cityQuery": "south bo"}' -H "SOAPAction:findCity" -H "content-type:application/json" | jq
