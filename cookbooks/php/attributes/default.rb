#default[:php][:extension_dir] = %x[/usr/local/bin/php -i | grep -P "^extension_dir"| awk -F"=> " '{print $2}'].rstrip
#default[:php][:scan_dir] = %x[/usr/local/bin/php -i | grep -P "Scan this dir"| awk -F"=> " '{print $2}'].rstrip
default[:php][:extension_dir] = "/usr/local/lib/php/extensions/no-debug-non-zts-20090626"
default[:php][:scan_dir] = "/usr/local/etc/php5/conf.d"
