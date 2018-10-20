# Small! woohoo
FROM debian:7-slim
EXPOSE 3001
RUN apt-get update && apt-get install -y ca-certificates && apt-get clean
ADD https://circleci-artifacts.now.sh/file/github/Schniz/circleci_redirection/master/circleci_redirection /app
RUN chmod u+x /app
CMD ["/app", "-p", "3001"]
