# Desafio teste da Lemoney

## Instruções de execução da aplicação apresentada:

### Heroku

A aplicação se encontra hospedada no Heroku, e para acessá-la basta ir em:

    lemoney-test.herokuapp.com

### Local

Para executar a aplicação localmente, basta seguir os passos normais de execução de uma aplicação Rails:

Se não estiver usando RVM, verificar se está usando o Ruby 2.4.x

    $ bundle install
    $ rails db:create
    $ rails db:schema:load
    $ rails db:seed
    $ rails s
    
O seeds irá criar um usuário admin, além de 50 ofertas geradas de forma
aleatória, sendo 15 sem uma data de fim, e 35 com data de fim.

### Para executar os testes automatizados, basta rodar o comando:

    $ rspec

### Para acessar a área de admin do sistema, faça login com o usuário admin criado pelo seeds:

    email: admin@example.com
    senha: 123456
