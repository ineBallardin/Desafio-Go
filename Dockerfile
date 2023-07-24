FROM golang:alpine AS builder

WORKDIR /usr/src/fullcycle

COPY . .

COPY go.mod ./
RUN go mod download && go mod verify

RUN go build -a -o fullcycle .

FROM scratch

WORKDIR /usr/src/fullcycle

COPY --from=builder /usr/src/fullcycle/fullcycle .

EXPOSE 4000

CMD ["./fullcycle"]