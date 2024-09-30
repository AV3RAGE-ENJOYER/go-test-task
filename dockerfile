FROM golang:latest
WORKDIR /usr/share/music_library/
COPY . .
RUN go mod download && go mod verify
RUN go build main.go
CMD ["./main"]