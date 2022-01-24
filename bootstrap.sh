# Download Elastic Search Debian Package
# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-amd64.deb
# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-amd64.deb.sha512

shasum -a 512 -c elasticsearch-7.15.2-amd64.deb.sha512 
sudo dpkg -i elasticsearch-7.15.2-amd64.deb


# TODO - Move to Separate

# Install Metric Beats
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.15.2-amd64.deb
sudo dpkg -i metricbeat-7.15.2-amd64.deb

metricbeat modules enable elasticsearch-xpack
hostname=`hostname`

cat <<EOF | sudo tee /etc/metricbeat/modules.d/elasticsearch-xpack.yml
- module: elasticsearch
  xpack.enabled: true
  period: 10s
  hosts: ["http://$hostname:9200"]
EOF


cat <<EOF | sudo tee /etc/metricbeat/metricbeat.yml
metricbeat.config.modules:

  # Glob pattern for configuration reloading
  path: \${path.config}/modules.d/*.yml

  # Period on which files under path should be checked for changes
  reload.period: 10s

  # Set to true to enable config reloading
  reload.enabled: false

# Maximum amount of time to randomly delay the start of a metricset. Use 0 to
# disable startup delay.
metricbeat.max_start_delay: 10s

output.elasticsearch:
  hosts: ["http://es-primary-01:9200"] ## Monitoring cluster
EOF

# Starting metricbeat
sudo service metricbeat start