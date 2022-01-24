# wget https://artifacts.elastic.co/downloads/kibana/kibana-7.16.3-amd64.deb
shasum -a 512 kibana-7.15.2-amd64.deb 
sudo dpkg -i kibana-7.15.2-amd64.deb

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service

cat <<EOF | sudo tee /etc/kibana/kibana.yml

server.host: kibana-01
elasticsearch.hosts: ["http://es-primary-01:9200/"]
EOF

sudo systemctl start kibana.service
