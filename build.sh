#/bin/sh
rm s.tar
JEKYLL_ENV=production bundle exec jekyll build
tar zcf s.tar _site/*
scp s.tar demo.etender.io:~/

