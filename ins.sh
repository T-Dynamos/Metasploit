cd $PREFIX/opt/metasploit-framework
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
gem install bundler
sed 's|nokogiri (1.*)|nokogiri (1.8.0)|g' -i Gemfile.lock

gem install nokogiri -- --use-system-libraries

gem install actionpack
bundle update activesupport
bundle update --bundler
bundle install -j$(nproc --all)
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
if [ -e $PREFIX/bin/msfconsole ];then
	rm $PREFIX/bin/msfconsole

fi
if [ -e $PREFIX/bin/msfvenom ];then
	rm $PREFIX/bin/msfvenom

fi
if [ -e $PREFIX/bin/msfdb];then
	rm $PREFIX/bin/msfdb

fi
if [ -e $PREFIX/bin/msfd];then
	rm $PREFIX/bin/msfd

fi
if [ -e $PREFIX/bin/msfrpc ];then
	rm $PREFIX/bin/msfrpc

if [ -e $PREFIX/bin/msfupdate ];then
	rm $PREFIX/bin/msfupdate

fi
ln -s PREFIX/opt/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/
ln -s PREFIX/opt/metasploit-framework/msfvenom /data/data/com.termux/files/usr/bin/
ln -s PREFIX/opt/metasploit-framework/msfupdate /data/data/com.termux/files/usr/bin/
ln -s PREFIX/opt/metasploit-framework/msfdb /data/data/com.termux/files/usr/bin/
ln -s PREFIX/opt/metasploit-framework/msfd /data/data/com.termux/files/usr/bin/
ln -s PREFIX/opt/metasploit-framework/msfrpc /data/data/com.termux/files/usr/bin/
termux-elf-cleaner /data/data/com.termux/files/usr/lib/ruby/gems/2.4.0/gems/pg-0.20.0/lib/pg_ext.so
cd PREFIX/opt/metasploit-framework/config
curl -sLO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/database.yml

mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql

pg_ctl -D $PREFIX/var/lib/postgresql start
createuser msf
createdb msf_database

cd PREFIX/opt
curl -sLO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/postgresql_ctl.sh
chmod +x postgresql_ctl.sh
