envsubst "$$(env | sed -e 's/=.*//' -e 's/^/\$$/g')" < /etc/nginx/docker/localhost.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'
