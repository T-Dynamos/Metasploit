cd $PREFIX/opt/metasploit-framework
termux-fix-shebang m* > /dev/null 2&>1
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
gem install bundler
sed 's|nokogiri (1.*)|nokogiri (1.8.0)|g' -i Gemfile.lock

gem install nokogiri -- --use-system-libraries
gem install nokogiri -v 1.8.0 -- --use-system-libraries
gem install actionpack
bundle update activesupport
bundle update --bundler
bundle install -j$(nproc --all)
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
rm $PREFIX/bin/msfconsole
rm $PREFIX/bin/msfvenom
rm $PREFIX/bin/msfdb
rm $PREFIX/bin/msfd
rm $PREFIX/bin/msfrpc
rm $PREFIX/bin/msfupdate
ln -s $PREFIX/opt/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/
ln -s $PREFIX/opt/metasploit-framework/msfvenom /data/data/com.termux/files/usr/bin/
ln -s $PREFIX/opt/metasploit-framework/msfupdate /data/data/com.termux/files/usr/bin/
ln -s $PREFIX/opt/metasploit-framework/msfdb /data/data/com.termux/files/usr/bin/
ln -s $PREFIX/opt/metasploit-framework/msfd /data/data/com.termux/files/usr/bin/
ln -s $PREFIX/opt/metasploit-framework/msfrpc /data/data/com.termux/files/usr/bin/
termux-elf-cleaner /data/data/com.termux/files/usr/lib/ruby/gems/2.4.0/gems/pg-0.20.0/lib/pg_ext.so
cd $PREFIX/opt/metasploit-framework/config
curl -sLO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/database.yml

mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql

pg_ctl -D $PREFIX/var/lib/postgresql start
createuser msf
createdb msf_database

cd $PREFIX/opt
curl -sLO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/postgresql_ctl.sh
chmod +x postgresql_ctl.sh
