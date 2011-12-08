#
# Chef Solo Config File
#
megalodon_root = "#{Dir.tmpdir}/megalodon"

log_level          :info
log_location       STDOUT
sandbox_path       "#{megalodon_root}/sandboxes"
file_cache_path    "#{megalodon_root}/cookbooks"
file_backup_path   "#{megalodon_root}/backup"
cache_options      ({ :path => "#{megalodon_root}/cache/checksums", :skip_expires => true })

# Optionally store your JSON data file and a tarball of cookbooks remotely.
#json_attribs "http://chef.example.com/dna.json"
#recipe_url   "http://chef.example.com/cookbooks.tar.gz"
cookbook_path File.expand_path(File.join(File.dirname(__FILE__), "..", "cookbooks"))
role_path     File.expand_path(File.join(File.dirname(__FILE__), "..", "roles"))
data_bag_path "#{ENV['HOME']}/.megalodon/data_bags"

Mixlib::Log::Formatter.show_time = false
