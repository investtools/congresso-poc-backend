# README

Implementação rails do backend para o projeto de poc do congresso.

Things you may want to cover:

* Ruby 2.4.1

* Usando sidekiq para jobs que publicam na blockchain

* Api que salva os dados do front (autorizacao de chave, voto, revogação de chave)

* Para criar o banco rake db:create

* Para rodar as migrations rake db:migrate

* Para rodar os testes, execute guard

# Ligando o projeto

* mysqld (banco)

* redis-server (banco para o sidekiq)

* foreman start (liga a aplicacao + sidekiq)

ou 

* mysqld&redis-server&foreman start