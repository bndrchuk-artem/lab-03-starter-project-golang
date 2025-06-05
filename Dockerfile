
FROM golang:1.24.3-alpine

WORKDIR /usr/local/app

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .
RUN go build -o build/fizzbuzz

EXPOSE 8080

CMD ["build/fizzbuzz", "serve"]