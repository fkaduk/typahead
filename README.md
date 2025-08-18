
# typeahead

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/fkaduk/typahead/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fkaduk/typahead/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/fkaduk/typahead/graph/badge.svg)](https://app.codecov.io/gh/fkaduk/typahead)
[![R-CMD-check](https://github.com/fkaduk/typaheadsa/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fkaduk/typaheadsa/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of typeahead is to ...

## Installation

The development version can be installed from
[GitHub](https://github.com/fkaduk/typeahead) with

```r
devtools::install_github("fkaduk/typahead")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(typeahead)
## basic example code
```

## Local Testing

`shinytest2` requires Chrome/Chromium for browser testing.

### Host System

Local testing on ubuntu requires to set:

```bash
export CHROMOTE_CHROME="/home/$USER/.cache/R/chromote/chrome/131.0.6778.85/chrome-headless-shell-linux64/chrome-headless-shell"
export CHROMOTE_CHROME_ARGS="--no-sandbox --no-proxy-server --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222"
```

### Docker

Another option is to run the tests in a container:


```bash
docker build -t typeahead-test . 

docker run --rm -v "$(pwd):/pkg" typeahead-test R -e "setwd('/pkg'); devtools::install_deps(dependencies = TRUE); devtools::install(); devtools::test()"
```

# TODO

- [ ] Suppress Shiny autoload warning during shinytest2 testing

