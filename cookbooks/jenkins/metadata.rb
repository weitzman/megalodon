maintainer       "Mark Sonnabaum"
maintainer_email "mark.sonnabaum@acquia.com"
license           "Apache 2.0"
description       "Installs Jenkins CI"
version           "0.9"

%w{ mac_os_x }.each do |os|
  supports os
end
