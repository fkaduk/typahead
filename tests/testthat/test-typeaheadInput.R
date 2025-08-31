describe("typeaheadInput unit tests", {
  it("generates a valid Shiny input widget", {
    # WHEN/THEN
    input <- typeaheadInput(
      inputId = "my_input",
      label = "Label",
      choices = c("A", "B")
    )

    expect_s3_class(input, "shiny.tag.list")
    deps <- htmltools::findDependencies(input)
    expect_true(length(deps) > 0)
  })

  it("includes provided choices and configuration", {
    # GIVEN
    choices <- c("apple", "banana", "cherry")

    # WHEN
    input <- typeaheadInput(
      inputId = "test",
      choices = choices,
      value = "apple"
    )

    # THEN
    input_str <- as.character(input)
    expect_true(grepl("apple", input_str))
    expect_true(grepl("banana", input_str))
    expect_true(grepl("cherry", input_str))
  })

  it("works with minimal required parameters", {
    # WHEN/THEN
    expect_no_error({
      minimal_input <- typeaheadInput(inputId = "minimal")
    })

    expect_s3_class(minimal_input, "shiny.tag.list")
  })
})
