# Тестовое задание Go Effective Mobile

**[Пример конфигурационного файла config.env](config.env)**

## Установка

### Docker
```bash
git clone https://github.com/AV3RAGE-ENJOYER/go-test-task
cd go-test-task
docker compose up -d
```

### Source

Для корректной работы приложения нужен работающий сервер **PostgreSQL** на **localhost**.

```bash
git clone https://github.com/AV3RAGE-ENJOYER/go-test-task
cd go-test-task
go mod download && go mod verify
go build main.go
./main
```