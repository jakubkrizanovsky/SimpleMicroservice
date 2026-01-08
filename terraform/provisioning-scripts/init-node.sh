#
# Basic node initialization
#

# Setup hostname
echo "${INIT_HOSTNAME}" > /etc/hostname
sed -i "s/127\.0\.0\.1 localhost.*/127.0.0.1 localhost ${INIT_HOSTNAME}/g" /etc/hosts

# Create firewall rules and save them
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -P INPUT DROP
iptables-save > /etc/network/iptables

# Restore firewall rules on reboot
cat > /etc/rc.local << EOL
#!/bin/sh -e
iptables-restore /etc/network/iptables
exit 0
EOL
chmod 755 /etc/rc.local

# Disable password authentication
sed -i 's/PasswordAuthentication .*/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd

echo "INIT Node done." >> ${INIT_LOG}

# EOF
