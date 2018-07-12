#!/bin/bash
#will make the services for the pool, based on the pool exe location of $poolbinary
user="akroma"
coin="akroma"
config_dir="/home/$user/cryptopools.info-pools/configs"
poolbinary="/home/$user/cryptopools.info-pools/build/bin/open-callisto-pool"

if [ ! -e $config_dir ] || [ ! -e $poolbinary ]
then
echo missing config dir or pool binary, exiting
echo have you run make yet?
exit 1
fi

#rename the callisto binary to pirl
pirlbinary="/home/$user/cryptopools.info-pools/build/bin/open-pirl-pool"
cp -f $poolbinary $pirlbinary

poolbinary=$pirlbinary

echo "
[Unit]
Description=$coin-api

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/api.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-api.service

echo "
[Unit]
Description=$coin-stratum2b

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/stratum2b.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-stratum2b.service


echo "
[Unit]
Description=$coin-stratum4b

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/stratum4b.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-stratum4b.service


echo "
[Unit]
Description=$coin-stratum9b


[Service]
Type=simple
ExecStart=$poolbinary $config_dir/stratum9b.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-stratum9b.service


echo "
[Unit]
Description=$coin-unlocker


[Service]
Type=simple
ExecStart=$poolbinary $config_dir/unlocker.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-unlocker.service

echo "
[Unit]
Description=$coin-payout

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/payout.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-payout.service

systemctl daemon-reload

systemctl enable $coin-api
systemctl enable $coin-stratum2b
systemctl enable $coin-stratum4b
systemctl enable $coin-stratum9b
systemctl enable $coin-unlocker
systemctl enable $coin-payout

systemctl start $coin-api
systemctl start $coin-stratum2b
systemctl start $coin-stratum4b
systemctl start $coin-stratum9b
systemctl start $coin-unlocker
systemctl start $coin-payout

#these working depend on your  node already being configured and running

