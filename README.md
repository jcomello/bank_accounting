# README

# Bank Accounting

Sistema de gerenciamento e transferência entre contas bancárias

## Requerimentos


- Ruby 2.6.3
- Postgres 10.10

## Setup

0) Faça o download deste repositório em um diretório de sua escolha

```
$ git clone git@github.com:jcomello/bank_accounting.git
$ cd bank_accouting
```

1) Instale as gems e crie o banco de dados::

```
$ bundle install
$ bundle exec rake db:setup
```

2) Rode a aplicação:

```
$ rails s
```

## Utilizando a aplicação

Para facilitar o uso da aplicação via API, foi criado uma [biblioteca de requests no postman](BankAccounting.postman_collection.json).
Ainda está em work in progress, mas já é funcional. Precisamos somente alterar os valores usados na biblioteca para variáveis do Postman.

### Recebendo acesso

Para receber acesso ao Bank Accouting você precisa fazer o cadastro de correntista. No momento, em nossa aplicação só é necessário enviar o seu nome para cadastrarmos como correntista e criarmos uma conta bancária.

```
 $ curl -H 'Accept: application/json' \
        -H 'Content-type: application/json' \
        -X POST http://localhost:3000/account_holders \
        -d '{ "name": "João Mello" }'

EXEMPLO DE RESPOSTA

{
  "id":7,
  "name":"João Mello",
  "token":"df71f9b4105751c4c1f4bc07c2bc0472",
  "created_at":"2020-01-22T18:06:19.773Z",
  "updated_at":"2020-01-22T18:06:19.773Z",
  "accounts":[{
    "id":7,
    "balance":100.0,
    "created_at":"2020-01-22T18:06:19.783Z",
    "updated_at":"2020-01-22T18:06:19.783Z"
  }]
}
```
Com seu token vindo como resposta você já pode fazer transferências bancárias para outras contas.
Com seu usuário criado você já possui uma contaválida. Para fazer uma transferêcia você precisa uma outra conta.
Basta criar um outro cadastro de correntista.

```
$ curl -H 'Accept: application/json' \
       -H 'Content-type: application/json' \
       -X POST http://localhost:3000/account_holders \
       -d '{ "name": "Letícia Carreira" }'

EXEMPLO DE RESPOSTA

{
  "id":8,
  "name":"Letícia Carreira",
  "token":"e727315eb94e99e66506a5e71a4cfc76",
  "created_at":"2020-01-22T18:14:04.112Z",
  "updated_at":"2020-01-22T18:14:04.112Z",
  "accounts":[{
    "id":8,
    "balance":100.0,
    "created_at":"2020-01-22T18:14:04.119Z",
    "updated_at":"2020-01-22T18:14:04.119Z"
  }]
}
```

Pronto, você já possui uma segunda conta. Agora já podemos criar uma transferência bancária.

### Fazendo uma transferência

Para fazer uma transferência basta passar os ids das contas de origem e destino e o valor a ser transferido em reais.

```
$ curl -H 'Authorization: Token df71f9b4105751c4c1f4bc07c2bc0472' \
       -H 'Accept: application/json' \
       -H 'Content-type: application/json' \
       -X POST http://localhost:3000/bank_transfers \
       -d '{ "source_account_id": 7, "destination_account_id": 8, "amount": 20.0 }'

EXEMPLO DE RESPOSTA

{
  "id":37,
  "source_account_id":7,
  "destination_account_id":8,
  "amount":20.0,
  "created_at":"2020-01-22T18:41:54.940Z",
  "updated_at":"2020-01-22T18:41:54.940Z"
}
```

### Consultando o saldo

Uma vez feita a transferência, natural que façamos a consulta do saldo de nossa conta. Para isso basta acessar o endpoint de consulta de saldo.

```
$ curl -H 'Authorization: Token df71f9b4105751c4c1f4bc07c2bc0472' \
       -H 'Accept: application/json' \
       -H 'Content-type: application/json' \
       -X GET http://localhost:3000/accounts/7

EXEMPLO DE RESPOSTA

{
  "id":7,
  "balance":80.0,
  "created_at":"2020-01-22T18:06:19.783Z",
  "updated_at":"2020-01-22T18:38:13.758Z"
}
```
### Decisões tomadas

Como em toda aplicação tomamos decisões importantes na hora de desenvolver. O importante é saber o motivo destas decisões e seus pontos positivos e negativos. As mais importantes são:

#### Serializers x API Views

Optei por utilizar os [ActiveModelSerializers](https://github.com/rails-api/active_model_serializers) por ser uma forma simples, reaproveitavel e facil de testar. Atualmente estão fazendo algumas renovações, mas o que está sendo usado não é impactado por essas mudanças.

#### Valores em centavos

Como são valores em dinheiro optei por salvar os valores em centavos, ou seja, em inteiros para facilitar as operações internamente. Nós não faremos arredondamentos com os valores e não queremos permitir frações de centavos.

#### Valores do saldo calculados

Uma decisão muito dificil de tomar foi a de atualizar o valor do saldo em cada uma das contas ou calculá-los sempre.

Optei por sempre calculá-los por ser uma aplicação ainda pequena e por ser mais simples de implementar. O cálculo do saldo tanto para a validação da transferência quanto para mostrar o saldo tem complexidade O(n). Assim, cada vez que criarmos uma transferência bancária a criação ficará mais lenta. Sabendo disso podemos no futuro criar valores parciais de saldo. Por exemplo: todo dia à meia noite nós congelamos o saldo bancário e em vez de calcularmos o saldo através de todas as transferências de saque e deposito usando com base o valor inicial, nós aplicamos as transferências feitas no dia da consulta no valor inicial do dia.

Isso simplifica nosso código na camada de controller, sendo que a operação que provavelmente será mais crítica é a de transferência bancária.


## Contribuindo

1. Crie uma issue ( https://github.com/[my-github-username]/bank_accounting/issues/new )
2. Faça fork ( https://github.com/[my-github-username]/bank_accounting/fork )
3. Crie sua feature branch (`git checkout -b my-new-feature`)
4. Faça commit de suas mudanças (`git commit -am 'Add some feature'`)
5. Faça Pash da sua branch (`git push origin my-new-feature`)
6. Crie um novo Pull Request

Espero que gostem :smile:
