set interfaces ethernet eth0 duplex 'auto'
set interfaces ethernet eth0 hw-id '52:54:00:d2:fc:b2'
set interfaces ethernet eth0 smp_affinity 'auto'
set interfaces ethernet eth0 speed 'auto'
set interfaces ethernet eth0 vif 34 address '192.168.34.101/24'
set interfaces ethernet eth1 address '10.10.10.1/29'
set interfaces ethernet eth1 duplex 'auto'
set interfaces ethernet eth1 hw-id '52:54:00:28:e3:42'
set interfaces ethernet eth1 smp_affinity 'auto'
set interfaces ethernet eth1 speed 'auto'
set interfaces ethernet eth2 address '10.10.1.1/30'
set interfaces ethernet eth2 duplex 'auto'
set interfaces ethernet eth2 hw-id '52:54:00:69:12:e2'
set interfaces ethernet eth2 smp_affinity 'auto'
set interfaces ethernet eth2 speed 'auto'
set interfaces ethernet eth3 address '10.10.1.5/30'
set interfaces ethernet eth3 duplex 'auto'
set interfaces ethernet eth3 hw-id '52:54:00:91:5b:c3'
set interfaces ethernet eth3 smp_affinity 'auto'
set interfaces ethernet eth3 speed 'auto'
set interfaces loopback 'lo'
set interfaces openvpn vtun0 description 'VPN'
set interfaces openvpn vtun0 encryption 'aes256'
set interfaces openvpn vtun0 mode 'server'
set interfaces openvpn vtun0 openvpn-option 'comp-lzo yes'
set interfaces openvpn vtun0 openvpn-option 'duplicate-cn'
set interfaces openvpn vtun0 server push-route '172.24.0.0/24'
set interfaces openvpn vtun0 server push-route '172.25.0.0/24'
set interfaces openvpn vtun0 server push-route '172.29.236.0/22'
set interfaces openvpn vtun0 server push-route '172.23.0.0/16'
set interfaces openvpn vtun0 server push-route '172.28.236.0/22'
set interfaces openvpn vtun0 server push-route '172.26.0.0/16'
set interfaces openvpn vtun0 server subnet '10.209.10.0/24'
set interfaces openvpn vtun0 tls ca-cert-file '/config/auth/ovpn/ca.crt'
set interfaces openvpn vtun0 tls cert-file '/config/auth/ovpn/server.crt'
set interfaces openvpn vtun0 tls dh-file '/config/auth/ovpn/dh2048.pem'
set interfaces openvpn vtun0 tls key-file '/config/auth/ovpn/server.key'
set nat source rule 100 outbound-interface 'eth0.34'
set nat source rule 100 'source'
set nat source rule 100 translation address 'masquerade'
set protocols bgp 64999 neighbor 10.10.1.2 ebgp-multihop '2'
set protocols bgp 64999 neighbor 10.10.1.2 remote-as '65011'
set protocols bgp 64999 neighbor 10.10.1.2 update-source '10.10.1.1'
set protocols bgp 64999 neighbor 10.10.1.6 ebgp-multihop '2'
set protocols bgp 64999 neighbor 10.10.1.6 remote-as '64998'
set protocols bgp 64999 neighbor 10.10.1.6 update-source '10.10.1.5'
set protocols bgp 64999 neighbor 10.10.10.3 ebgp-multihop '2'
set protocols bgp 64999 neighbor 10.10.10.3 remote-as '64511'
set protocols bgp 64999 neighbor 10.10.10.3 update-source '10.10.10.1'
set protocols bgp 64999 network '0.0.0.0/0'
set protocols bgp 64999 parameters router-id '10.10.1.1'
set protocols 'static'
set service dns forwarding cache-size '0'
set service dns forwarding listen-on 'eth1'
set service dns forwarding name-server '192.168.114.14'
set service dns forwarding name-server '192.168.114.15'
set service ssh port '22'
set system config-management commit-revisions '20'
set system console device ttyS0 speed '9600'
set system gateway-address '192.168.34.1'
set system host-name 'dc-1-core-sw-1'
set system login user vyos authentication encrypted-password '$1$aSgSsRu7$ip4OGP/3hMCFmF6iUfvJe0'
set system login user vyos authentication plaintext-password ''
set system login user vyos level 'admin'
set system ntp server '0.pool.ntp.org'
set system ntp server '1.pool.ntp.org'
set system ntp server '2.pool.ntp.org'
set system package auto-sync '1'
set system package repository community components 'main'
set system package repository community distribution 'helium'
set system package repository community password ''
set system package repository community url 'http://packages.vyos.net/vyos'
set system package repository community username ''
set system syslog global facility all level 'notice'
set system syslog global facility protocols level 'debug'
set system time-zone 'UTC'
