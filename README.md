
# typeahead

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/fkaduk/typahead/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fkaduk/typahead/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/fkaduk/typahead/graph/badge.svg)](https://app.codecov.io/gh/fkaduk/typahead)
<!-- badges: end -->

The `typeahead` package provides a versatile autocomplete text input component
for R Shiny applications or R markdown.
It wraps the typeahead-standalone JavaScript library
to deliver both client-side type-ahead functionality
with dropdown and inline suggestions.

## Installation

The development version can be installed from
[GitHub](https://github.com/fkaduk/typeahead) via

```r
devtools::install_github("fkaduk/typahead")
```

## Example

Here's a basic example showing how to create a typeahead input:

``` r
library(shiny)
library(typeahead)

ui <- fluidPage(
  typeaheadInput(
    inputId = "city",
    label = "Choose a city:",
    choices = c("Berlin", "Boston", "Barcelona", "Brussels", "Buenos Aires"),
    placeholder = "Start typing..."
  ),
  
  verbatimTextOutput("selected")
)

server <- function(input, output) {
  output$selected <- renderText({
    paste("You selected:", input$city)
  })
}

shinyApp(ui = ui, server = server)
```

## Local Testing

`shinytest2` requires Chrome/Chromium for browser testing.

### On Host

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

