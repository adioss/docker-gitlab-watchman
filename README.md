# docker-gitlab-watchman

Docker image for [gitlab-watchman](https://github.com/PaperMtn/gitlab-watchman)

gitlab-watchman uses the GitLab API to audit GitLab for sensitive data and credentials exposed internally.

## Build

```
docker build -t adioss/gitlab-watchman .
```

## Usage

### Prerequisites

You need a personal access token

* go to the GitLab GUI
* Settings -> Access Tokens -> Add a personal access token
* scopes: _api_

### Basics

```
// help
docker run --rm adioss/gitlab-watchman -h

// scan all
docker run --rm -e GITLAB_WATCHMAN_TOKEN=abc123 -e GITLAB_WATCHMAN_URL=https://gitlab.example.com adioss/gitlab-watchman --timeframe a --all
docker run --rm --env-file .env adioss/gitlab-watchman --timeframe a --all

// output into a file
docker run --rm -v $PWD/log:/home/gitlab-watchman/log -e GITLAB_WATCHMAN_TOKEN=abc123 -e GITLAB_WATCHMAN_URL=https://gitlab.example.com -e GITLAB_WATCHMAN_LOG_PATH=/home/gitlab-watchman/log adioss/gitlab-watchman --timeframe a --all --output file 
docker run --rm -v $PWD/log:/home/gitlab-watchman/log --env-file .env adioss/gitlab-watchman --timeframe a --all --output file
```

example of .env:

```
GITLAB_WATCHMAN_URL=https://gitlab.example.com
GITLAB_WATCHMAN_TOKEN=abc123
GITLAB_WATCHMAN_LOG_PATH=/home/gitlab-watchman/log
```