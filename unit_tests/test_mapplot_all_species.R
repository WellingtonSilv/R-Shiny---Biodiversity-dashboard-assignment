library(testthat)

species_df <- fread("species_df.csv")

test_that(
  "This test, veryfies if mapplot_all_species function it's returnig a plotly object",
  {
    expect_equal(class(mapplot_all_species(data = species_df))[1],
                 "plotly"
    )
  }
)