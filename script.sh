#!/bin/bash

echo "Current directory: $(pwd)"

# Перейти в директорию /vagrant
cd /vagrant/js-fastify-blog

# Вывести текущую директорию после перехода
echo "Directory after cd: $(pwd)"



# Обновление списка пакетов и установка необходимых зависимостей
sudo apt-get update -y
sudo apt-get upgrade -y

# Установка Node.js через NodeSource
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Проверка установки Node.js
node -v
npm -v

# Добавление репозитория PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Установка PostgreSQL
sudo apt-get update -y
sudo apt-get install -y postgresql postgresql-contrib

# Запуск и включение сервиса PostgreSQL

# Создание роли "vagrant" в PostgreSQL и базы данных с именем "vagrant"
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '1111';"
sudo -u postgres psql -c "CREATE ROLE vagrant WITH LOGIN SUPERUSER PASSWORD '1111';"
sudo -u postgres createdb vagrant
sudo -u postgres psql -c "SELECT version();"

# Установить необходимые зависимости
make install

# Собрать проект
make build

# Создание сикретов
make prepare-env