## vagrant-es

Vagrant configuration to run Elastic Search in clustered environment using VirtualBox as provisioner

## Running Locally

Run [`get_es.sh`](shared/get_es.sh) to download ES locally. This Elastic Search package will be used to install Elasticsearch on primary and data nodes.

```
./shared/get_es.sh
```

### Install Vagrant Host Manager

```
vagrant plugin install vagrant-hostmanager
```

### Vagrant Commands
```bash
vagrant up
vagrant status
vagrant destroy
```

### Elastic Search
```bash
# Health
http://es-primary-01:9200/_cat/health

# Nodes
http://es-primary-01:9200/_cat/nodes
```

## Issues

#### VBoxManage: error: Failed to create the host-only adapter

1. Open VirtualBox and shut down every VM running
2. Go to System Preferences > Security & Privacy Then hit the "Allow" button to let Oracle (VirtualBox) load.
3. Restart VirtualBox

## References
* https://gist.github.com/grbinho/c9c9340c467419a4121b
* https://www.elastic.co/guide/en/elasticsearch/reference/6.8/discovery-settings.html#minimum_master_nodes
* https://devconnected.com/how-to-install-an-elasticsearch-cluster-on-ubuntu-18-04/