describe("Null coalescing operator (%||%)", {
  it("returns right-hand side when left is NULL", {
    expect_equal(NULL %||% "default", "default")
  })

  it("returns left-hand side when not NULL", {
    expect_equal("value" %||% "default", "value")
  })

  it("treats NA as non-NULL", {
    expect_equal(NA %||% "default", NA)
  })

  it("treats 0 as non-NULL", {
    expect_equal(0 %||% "default", 0)
  })

  it("treats empty string as non-NULL", {
    expect_equal("" %||% "default", "")
  })
})

describe("dropNulls", {
  it("removes NULL elements from list", {
    test_list <- list(a = 1, b = NULL, c = "test", d = NULL, e = 5)
    result <- dropNulls(test_list)

    expect_equal(length(result), 3)
    expect_equal(result$a, 1)
    expect_equal(result$c, "test")
    expect_equal(result$e, 5)
    expect_null(result$b)
    expect_null(result$d)
  })

  it("works with vectors", {
    test_vector <- c("a", NULL, "b", NULL, "c")
    result <- dropNulls(test_vector)

    expect_equal(result, c("a", "b", "c"))
  })

  it("returns empty list when all elements are NULL", {
    test_list <- list(a = NULL, b = NULL)
    result <- dropNulls(test_list)

    expect_equal(length(result), 0)
  })

  it("returns unchanged list when no NULL elements", {
    test_list <- list(a = 1, b = "test", c = TRUE)
    result <- dropNulls(test_list)

    expect_equal(result, test_list)
  })
})
