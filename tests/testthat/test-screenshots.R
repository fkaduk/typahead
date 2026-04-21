library(testthat)
library(shiny)
library(shinytest2)

testthat::skip_on_ci()
testthat::skip_on_cran()

new_app <- function(..., name) {
  AppDriver$new(
    ...,
    name = name,
    variant = platform_variant(),
    seed = 1,
    width = 400,
    height = 400
  )
}

basic_ui <- function(...) {
  fluidPage(
    ...,
    typeaheadInput(
      inputId = "city",
      label = "City",
      choices = c("Berlin", "Boston", "Barcelona", "Brussels"),
      placeholder = "Start typing..."
    )
  )
}

dark_ui <- function(...) {
  bslib::page_fluid(
    theme = bslib::bs_theme(version = 5, preset = "darkly"),
    ...,
    typeaheadInput(
      inputId = "city",
      label = "City",
      choices = c("Berlin", "Boston", "Barcelona", "Brussels"),
      placeholder = "Start typing..."
    )
  )
}

describe("typeaheadInput screenshot tests", {
  it("renders idle state", {
    app <- new_app(
      shinyApp(ui = basic_ui(), server = function(...) {}),
      name = "typeahead-idle"
    )
    app$wait_for_idle()
    app$expect_screenshot()
    app$stop()
  })

  it("renders with suggestions", {
    app <- new_app(
      shinyApp(ui = basic_ui(), server = function(...) {}),
      name = "typeahead-suggestions"
    )
    app$run_js(js_input_event_set("city", "B"))
    app$wait_for_js(js_wait_for_suggestions())
    app$run_js("document.head.insertAdjacentHTML('beforeend', '<style>*{transition:none!important;animation:none!important}</style>')")
    app$expect_screenshot()
    app$stop()
  })

  it("renders idle state in dark theme", {
    app <- new_app(
      shinyApp(ui = dark_ui(), server = function(...) {}),
      name = "typeahead-dark-idle"
    )
    app$wait_for_idle()
    app$expect_screenshot()
    app$stop()
  })

  it("renders with suggestions in dark theme", {
    app <- new_app(
      shinyApp(ui = dark_ui(), server = function(...) {}),
      name = "typeahead-dark-suggestions"
    )
    app$run_js(js_input_event_set("city", "B"))
    app$wait_for_js(js_wait_for_suggestions())
    app$run_js("document.head.insertAdjacentHTML('beforeend', '<style>*{transition:none!important;animation:none!important}</style>')")
    app$expect_screenshot()
    app$stop()
  })
})
