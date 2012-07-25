default['megalodon']['brew_prefix'] = `brew --prefix`.strip
default['megalodon']['php_version'] = `brew --prefix php`.strip.split('/').last
default['megalodon']['docroot'] = "#{default['megalodon']['brew_prefix']}/var/www"
