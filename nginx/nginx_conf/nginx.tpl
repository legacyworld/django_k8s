user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
  worker_connections  1024;
}

http {
  client_max_body_size 10M;
  client_body_temp_path /usr/share/nginx/html;
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
  access_log  /var/log/nginx/access.log  main;
  sendfile        on;
  keepalive_timeout  65;

  server{
    listen 80;
    server_name nginx;
    location / {
      proxy_request_buffering off;
      include uwsgi_params;
      uwsgi_pass django:8000;
    }
    location /static {
      proxy_request_buffering off;
      root /usr/share/nginx/html;
    }
  }
}
