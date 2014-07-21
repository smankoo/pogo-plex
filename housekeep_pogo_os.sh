ls -1t /media/pogo_hd1/others/pogo_os/pogo_os.*.tar.gz | tail -n +7 | while read FILE; do rm $FILE; done
