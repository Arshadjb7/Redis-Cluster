curl -k -X POST https://13.203.232.153:9443/v1/bdbs \
  -u "arshadjb7123@gmail.com:Arshadashu@907157" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "db-withn-replica",
    "memory_size": 1073741824,
    "type": "redis",
    "replication": true
  }'
