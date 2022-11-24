library(testthat)

species_df <- fread("species_df.csv")

test_that(
  "This test, veryfies if mapplot_animated function it's returnig a plotly object",
  {
    expect_equal(class(mapplot_animated(data = species_df))[1],
                 "plotly"
    )
  }
)