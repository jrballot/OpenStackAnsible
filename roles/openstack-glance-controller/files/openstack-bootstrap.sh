openstack user create --domain default --password qwe123qwe glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image

openstack endpoint create --region RegionOne image public http://192.168.0.10:9292
openstack endpoint create --region RegionOne image internal http://192.168.100.10:9292
openstack endpoint create --region RegionOne image admin http://192.168.100.10:9292
