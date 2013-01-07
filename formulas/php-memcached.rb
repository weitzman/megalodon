require 'formula'

class PhpMemcached <Formula
  url 'http://pecl.php.net/get/memcached-2.1.0.tgz'
  homepage 'http://pecl.php.net/package/memcached'
  md5 'daf070aad13bebffdff50acf6e93043c'

  depends_on 'autoconf' => :build
  depends_on 'libmemcached'

  def install
    extensions = lib + %x[php-config --extension-dir].split('lib/')[1].strip
    Dir.chdir "memcached-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}"
      system "make"

      extensions.install "modules/memcached.so"
    end

  end

  def caveats; <<-EOS.undent
    To finish installing memcached:
     * Add the following lines to php.ini:
        [memcached]
        extension="#{prefix}/memcached.so"
     * Restart your webserver
    EOS
  end
end
