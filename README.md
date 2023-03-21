# node_exporter_ntpd
For scraping this metrics enable textfile collector. For example add parameter --collector.textfile.directory=/var/lib/node_exporter/textfile_collector and restart service

Add ntpdmon.sh script to /usr/local/bin/ntpdmon.sh

Add crontab for run script (use command crontab -e)

*/5 * * * * /usr/local/bin/openntpdmon.sh > /var/lib/node_exporter/textfile_collector/ntpd_metrics.prom

