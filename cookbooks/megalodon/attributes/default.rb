default['megalodon']['brew_prefix'] = `brew --prefix`.strip
default['megalodon']['php_prefix'] = `brew --prefix php`.strip
default['megalodon']['docroot'] = "#{default['megalodon']['brew_prefix']}/var/www"
