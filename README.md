# Свое S3-хранилище

- поднимает кластер из 4-ех серверов minIO, балансировщик на nginx
- перед запуском, надо переименовать `.env.example` в `.env` и заполнить сгенерированными ключами поля (они же будут кредами для доступа)
- доступ будет по ссылке `localhost:80`, если не менять переменную `NGINX_PORT`

## Взаимодействовать

- можно через WebUI
- можно через [mcli](https://min.io/download#/)

## Автор
   * **Vassiliy Yegorov** - *Initial work* - [vasyakrg](https://github.com/)
