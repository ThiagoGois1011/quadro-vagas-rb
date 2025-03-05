# Documentação do Projeto Rails com Docker

## Visão Geral

Este projeto é uma aplicação **Rails** (Ruby on Rails) configurada para rodar dentro de um ambiente **Docker**. O uso do Docker facilita a configuração e o gerenciamento do ambiente de desenvolvimento e produção, garantindo consistência em diferentes sistemas operacionais e evitando problemas comuns relacionados a configurações de ambiente.

## Requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

Após a instalação, você pode verificar se tudo está correto com os seguintes comandos:

```bash
docker --version
docker-compose --version
```

## Passo a passo para executar

Faça o build das imagens.

```bash
docker-compose build
```
Execute as imagens para abrir o container.

```bash
docker-compose up
```

Em outro terminal, você pode rodar esse comando para manipular os código dentro do container do rails.

```bash
docker-compose exec web bash
```

Após carregar, você pode rodar os testes dentro dele e executar qualquer ação do rails. Para sair, basta rodar um ```exit```.

Para derrubar a aplicação do docker, basta dar um CRL + C no terminal em que ele foi aberto ou rodar esse comando para encerrá-lo:

```bash
docker-compose down
```

