default['megalodon']['brew_prefix'] = `brew --prefix`.strip
default['megalodon']['php_version'] = `brew info php| head -1 | awk '{print $2}'`.strip
default['megalodon']['docroot'] = "#{default['megalodon']['brew_prefix']}/var/www"
