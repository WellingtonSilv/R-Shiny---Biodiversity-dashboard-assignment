library(testthat)

species_df <- fread("species_df.csv")

test_that(
  "This test, veryfies if mapplot function it's returnig a plotly object",
  {
    expect_equal(class(mapplot(data = species_df, inputs = c("Elk","Eurasian Badger",
                                                       "Large Redeye","Eurasian Jay",
                                                       "Eurasian Wren","Eurasian Otter")))[1],
                 "plotly"
                 )
  }
)
