# Builder
FROM rust:1.79 AS builder
WORKDIR /app
ADD . /app
RUN cargo build --release

# Runtime
FROM gcr.io/distroless/cc
COPY --from=builder /app/target/release/rust-web /
COPY --from=builder /app/Rocket.toml /
CMD ["./rust-web"]
