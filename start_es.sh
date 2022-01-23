echo "## chown elasticsearch:elasticsearch"
sudo chown root:elasticsearch -R \
    /etc/elasticsearch \
    /usr/share/elasticsearch \
    /var/lib/elasticsearch \
    /var/log/elasticsearch

echo "## chmod 775"
sudo chmod 775 -R \
    /etc/elasticsearch \
    /usr/share/elasticsearch \
    /var/lib/elasticsearch \
    /var/log/elasticsearch
    
# Running with systemd
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service