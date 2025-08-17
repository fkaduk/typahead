#' Types a single character into <input id = inputId>.
#'
#' @param inputId Single, non-empty character string: the HTML id of your input.
#' @param value Single character to “type”.
#' @return character length 1
#' @return A JS string ready for `AppDriver$run_js()`.
js_type_letter <- function(inputId, value) {
  stopifnot(
    length(inputId) == 1L,
    is.character(inputId),
    nzchar(inputId),
    grepl("^[A-Za-z][A-Za-z0-9_:\\-\\.]*$", inputId)
  )

  stopifnot(
    length(value) == 1L,
    is.character(value),
    nzchar(value),
    nchar(value, type = "bytes") > 0L
  )

  sprintf(
    paste(
      "const el = document.getElementById(%s);",
      "if (!el) throw new Error('Element %s not found in DOM');",
      "el.value = %s;", # set 1-char value
      "el.dispatchEvent(new InputEvent('input', {", # fire `input`
      "  data: %s, inputType: 'insertText', bubbles: true",
      "}));",
      sep = "\n"
    ),
    jsonlite::toJSON(inputId, auto_unbox = TRUE),
    inputId,
    jsonlite::toJSON(value, auto_unbox = TRUE),
    jsonlite::toJSON(value, auto_unbox = TRUE)
  )
}
