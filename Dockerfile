FROM crystallang/crystal
RUN apt-get update && apt-get install python-pip -y && pip install -U grip
ADD shard.yml shard.lock /src/
WORKDIR /src
RUN shards install
ADD . /src
RUN shards build --production --static

# Small! woohoo
FROM debian:7-slim
EXPOSE 3001
RUN apt-get update && apt-get install -y ca-certificates && apt-get clean
COPY --from=0 /src/bin/circleci_redirection /app
CMD ["/app", "-p", "3001"]
