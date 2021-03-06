#!/bin/sh
#-----------------------------------------------------------------------------#
# eFa 4.0.0 initial apache-configuration script
#-----------------------------------------------------------------------------#
# Copyright (C) 2013~2017 https://efa-project.org
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
# Source the settings file
#-----------------------------------------------------------------------------#
source /usr/src/eFa/eFa-settings.inc
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
# Start configuration of apache
#-----------------------------------------------------------------------------#
rm -f /etc/httpd/conf.d/welcome.conf

# Remove not needed modules from Apache config 00-base.conf
sed -i 's/LoadModule version_module modules\/mod_version.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule actions_module modules\/mod_actions.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule authn_anon_module modules\/mod_authn_anon.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule authn_dbd_module modules\/mod_authn_dbd.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule authn_dbm_module modules\/mod_authn_dbm.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule authn_socache_module modules\/mod_authn_socache.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule authz_dbd_module modules\/mod_authz_dbd.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule authz_dbm_module modules\/mod_authz_dbm.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule autoindex_module modules\/mod_autoindex.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule cache_module modules\/mod_cache.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule cache_disk_module modules\/mod_cache_disk.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule data_module modules\/mod_data.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule dbd_module modules\/mod_dbd.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule dumpio_module modules\/mod_dumpio.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule echo_module modules\/mod_echo.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule env_module modules\/mod_env.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule expires_module modules\/mod_expires.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule ext_filter_module modules\/mod_ext_filter.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule filter_module modules\/mod_filter.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule headers_module modules\/mod_headers.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule include_module modules\/mod_include.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule info_module modules\/mod_info.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule negotiation_module modules\/mod_negotiation.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule remoteip_module modules\/mod_remoteip.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule socache_dbm_module modules\/mod_socache_dbm.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule socache_memcache_module modules\/mod_socache_memcache.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule socache_shmcb_module modules\/mod_socache_shmcb.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule status_module modules\/mod_status.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule status_module modules\/mod_status.so/#&/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/LoadModule userdir_module modules\/mod_userdir.so/#&/' /etc/httpd/conf.modules.d/00-base.conf

# Remove not needed modules from Apache config 00-dav.conf
sed -i 's/LoadModule dav_module modules\/mod_dav.so/#&/' /etc/httpd/conf.modules.d/00-dav.conf
sed -i 's/LoadModule dav_fs_module modules\/mod_dav_fs.so/#&/' /etc/httpd/conf.modules.d/00-dav.conf
sed -i 's/LoadModule dav_lock_module modules\/mod_dav_lock.so/#&/' /etc/httpd/conf.modules.d/00-dav.conf

# Remove not needed modules from Apache config 00-lua.conf
sed -i 's/LoadModule lua_module modules\/mod_lua.so/#&/' /etc/httpd/conf.modules.d/00-lua.conf

# We don't use auto index so remove the file
mv /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.orig

# TODO check what can be removed from:
#/etc/httpd/conf.modules.d/00-mpm.conf
#/etc/httpd/conf.modules.d/00-proxy.conf
#/etc/httpd/conf.modules.d/00-ssl.conf
#/etc/httpd/conf.modules.d/00-systemd.conf
#/etc/httpd/conf.modules.d/01-cgi.conf
#/etc/httpd/conf.modules.d/10-mod_security.conf
#/etc/httpd/conf.modules.d/10-php.conf

# Configure HTTP
sed -i '/    Options Indexes FollowSymLinks/ c\    Options None' /etc/httpd/conf/httpd.conf

# Configure SSL
sed -i '/^#Listen 443/ c\Listen 443 https' /etc/httpd/conf.d/ssl.conf
sed -i "/^SSLProtocol/ c\SSLProtocol all -SSLv2 -SSLv3" /etc/httpd/conf.d/ssl.conf
echo -e "RewriteEngine On" > /etc/httpd/conf.d/redirectssl.conf
echo -e "RewriteCond %{HTTPS} !=on" >> /etc/httpd/conf.d/redirectssl.conf
echo -e "RewriteRule ^/?(.*) https://%{SERVER_NAME}/\$1 [R,L]" >> /etc/httpd/conf.d/redirectssl.conf

# Disable PHP functions
sed -i '/disable_functions =/ c\disable_functions = apache_child_terminate,apache_setenv,define_syslog_variables,escapeshellcmd,eval,fp,fput,ftp_connect,ftp_exec,ftp_get,ftp_login,ftp_nb_fput,ftp_put,ftp_raw,ftp_rawlist,highlight_file,ini_alter,ini_get_all,ini_restore,inject_code,openlog,phpAds_remoteInfo,phpAds_XmlRpc,phpAds_xmlrpcDecode,phpAds_xmlrpcEncode,posix_getpwuid,posix_kill,posix_mkfifo,posix_setpgid,posix_setsid,posix_setuid,posix_setuid,posix_uname,proc_close,proc_get_status,proc_nice,proc_open,proc_terminate,syslog,system,xmlrpc_entity_decode,curl_multi_exec' /etc/php.ini
