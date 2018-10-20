# [CircleCI Artifact Redirection](https://circleci-artifacts.now.sh)
> [See the source!](https://github.com/Schniz/circleci_redirection)

This service redirects you to the latest build artifacts in CircleCI.
It can help you use Circle CI's artifact system to provide binaries or even serve
your documentation.

## Usage

There is one route to this service:
`/:lookup/github/:repo_owner/:repo/:branch/*path`

## Parameters

> All parameters are case sensitive!

- `:lookup` can be `file` for exact file, or `wildcard` to support wildcards
- `:repo_owner` is the github organization or username
- `:repo` is the github repository name
- `:branch` is the branch name
- `*path` is the rest of the path. If `lookup` is `wildcard`, you can use wildcards to
  find files easily.

## Examples

- `/file/github/TechMagister/couchdb.cr/master/docs/index.html` will redirect you to
  the docs of the CouchDB.cr crystal shard. [Try it here!](/file/github/TechMagister/couchdb.cr/master/docs/index.html)
- `/wildcard/github/crystal-lang/crystal/master/*linux-x86_64.tar.gz` would give you
  the latest nightly Crystal release. [Try it here!](/wildcard/github/crystal-lang/crystal/master/*linux-x86_64.tar.gz)

## Contributing

1. Fork it (<https://github.com/Schniz/circleci_redirection/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. :moneybag:

## Contributors

- [Schniz](https://github.com/Schniz) Gal Schlezinger - creator, maintainer
