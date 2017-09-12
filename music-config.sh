server {
ssl off;
listen 453;

   ssl_certificate /etc/nginx/ssl/nginx.crt;
   ssl_certificate_key /etc/nginx/ssl/nginx.key;

   access_log              /root/access.log;
   error_log               /root/error.log;

   server_name 192.161.0.100;
   charset utf-8;

   root /usr/local/var/www/music/;

   location / {
     index index.html;
    }

   location /play/ {
    if ($http_range = '') { return 403; }
    rewrite ^/play/([a-zA-Z0-9_\-]*)/([0-9]*)/([0-9]*)/(.*)/(.*) /songs/$2/$                                                                                        4.$5?e=$3&t=$1 break;

    add_header            Cache-Control  'private, max-age=0, must-revalidat                                                                                        e';
    add_header            Strict-Transport-Security "max-age=16070400; inclu                                                                                        deSubdomains";
    add_header            X-Frame-Options DENY;
  }

   location ~ \.(mp3|jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|pdf|txt|tar                                                                                        |wav|bmp|rtf|js|flv|swf|html|htm)$ {
     deny                  all;
   }
}
