FROM golang:1.24.3-alpine AS builder

WORKDIR /usr/local/app

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .
RUN go build -o build/fizzbuzz

# Етап запуску
FROM gcr.io/distroless/static-debian12

# Копіюємо бінарник і шаблони
COPY --from=builder /usr/local/app/build/fizzbuzz /app/fizzbuzz
COPY --from=builder /usr/local/app/templates /app/templates

WORKDIR /app
EXPOSE 8080
CMD ["./fizzbuzz", "serve"]