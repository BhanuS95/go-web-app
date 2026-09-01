FROM golang:1.27-bookworm AS build
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o go-web-app

#Final stage
FROM gcr.io/distroless/static-debian13:nonroot
WORKDIR /app
COPY --from=build /app/go-web-app .
COPY --from=build /app/static ./static
EXPOSE 8080
CMD ["./go-web-app"]
