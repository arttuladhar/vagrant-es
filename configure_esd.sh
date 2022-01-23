cat <<EOF | sudo tee /etc/elasticsearch/elasticsearch.yml
cluster.name: "vagrant-cluster"
# xpack.license.self_generated.type=trial

##
node.roles: [ data ]

## Network
network.host: _eth1:ipv4_
network.publish_host: _eth1:ipv4_
transport.publish_host: _eth1:ipv4_

##
discovery.seed_hosts: ["es-primary-01:9300","es-primary-02:9300"]
# discovery.zen.ping.unicast.hosts: ["192.168.57.6", "192.168.57.7"]

## No need as swap is completely off
# bootstrap.memory_lock: true
http.port: 9200
transport.port: 9300

## Logs
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
EOF

sudo chown root:elasticsearch /etc/elasticsearch/elasticsearch.yml