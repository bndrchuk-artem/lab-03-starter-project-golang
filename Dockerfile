# Етап збірки
FROM golang:1.24.3-alpine AS builder

WORKDIR /usr/local/app

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .
RUN go build -o build/fizzbuzz

# Етап запуску
FROM scratch

WORKDIR /app
COPY --from=builder /usr/local/app/build/fizzbuzz ./fizzbuzz

EXPOSE 8080
CMD ["./fizzbuzz", "serve"]