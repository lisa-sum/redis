#!/bin/bash

# 默认的环境变量
: "${DATA:="/mnt/data/155/docker/redis/data"}"
: "${CONFIG:="/mnt/data/155/docker/redis/config"}"
: "${PORT:="31379"}"
: "${CONTAINER_PORT:="6379"}"

mkdir -p $DATA
mkdir -p $CONFIG

cd $CONFIG || exit

cat > redis.conf <<EOF
# 设置 Redis 数据库的端口号
port $CONTAINER_PORT

# 设置 Redis 监听的连接队列的最大长度
tcp-backlog 511

# 设置 Unix 套接字的路径
# unixsocket /run/redis.sock
# unixsocketperm 700

# 设置客户端空闲超时时间
timeout 0

# 设置 TCP keepalive
tcp-keepalive 300

# 启用 AOF 持久化
appendonly yes

# 设置 AOF 文件的同步方式
appendfsync everysec

# 设置 AOF 文件的重写条件
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb

# 设置 RDB 持久化
save 900 1
save 300 10
save 60 10000

# 设置最大内存使用策略
maxmemory 4gb
maxmemory-policy allkeys-lru

# 设置密码
requirepass 263393

# 启用 protected mode
protected-mode yes

# 启用 RDB 文件压缩
rdbcompression yes

# 启用 RDB 文件校验
rdbchecksum yes

# 禁用透明大页
echo never > /sys/kernel/mm/transparent_hugepage/enabled
EOF

cat > redis-docker-compose.yml <<EOF
version: '3'

services:
  redis-stand-alone:
    image: redis:latest
    restart: always
    container_name: redis
    volumes:
      - ${DATA}:/data
      - ${CONFIG}/redis.conf:/etc/redis/redis.conf
    ports:
      - "${PORT}:${CONTAINER_PORT}"
    logging:
      options:
        max-size: "100m"
        max-file: "2"
EOF

cat redis-docker-compose.yml
sleep 4
cat redis.conf
sleep 4
docker-compose -f redis-docker-compose.yml up -d
sleep 4
docker ps
sleep 4
docker logs -f redis
