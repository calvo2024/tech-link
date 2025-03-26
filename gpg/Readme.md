gpg --list-keys
gpg --generate-key -u Mau
gpg -se -u Mau -r Mau cleartext.txt
gpg -d -u Mau cleartext.txt.gpg
gpg --export -u Mau --output Mau.gpg
gpg -se -u Calvo -r Mau cleartext.txt
gpg --export -u Calvo --output Calvo.gpg Calvo
cat Calvo.gpg | base64 > Calvo.asc

root@server1:/# gpg --import /opt/gpg/Calvo.gpg