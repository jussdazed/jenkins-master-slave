server {
  listen 80;
  listen [::]:80;

  server_name 192.168.23.10;

  location / {
proxy_pass          http://localhost:8080;

}
}
