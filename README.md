# SET UP

```
$ git clone https://github.com/s14228so/ECS-Rails6.git
$ cd ECS-Rails6
$ docker-compose run app rails new . --force --database=mysql --api
$ vi config/database.yml
```


- daatabase.ymlの編集
```
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: password #編集
  host: db #編集
# ...省略
production:
  <<: *default
  database: <%= ENV['DB_DATABASE'] %>
  adapter: mysql2
  encoding: utf8mb4
  charset: utf8mb4
  collation: utf8mb4_general_ci
  host: <%= ENV['DB_HOST'] %>
  username: <%= ENV['DB_USERNAME'] %>
  password: <%= ENV['DB_PASSWORD'] %>


```


```
$ vi config/environments/development.rb
```



```development.rb
Rails.application.configure do
  config.hosts.clear #追加
```



```
$ cp docker/rails/puma.rb config/ (pumaの設定を上書き)
$ mkdir -p tmp/sockets  (socketファイルの置き場所を確保)
$ docker-compose up -d --build 
$ docker-compose run app rails db:create
```
