# this function plots an animated map with all observerd species in poland over the years
mapplot_animated <- function(data = NULL){
  
  # creating frames to be animated based on year
  df <- data
  
  fig <- df
  
  fig <- fig %>%
    plot_ly(
      lat = ~latitudeDecimal,
      lon = ~longitudeDecimal,
      size = ~individualCount,
      fill = ~'',
      frame = ~year,
      marker = list(color=seq(1,1000), colorscale='Viridis',
                    reversescale =T, sizemode = 'diameter'),
      type = 'scattermapbox',
      mode = 'markers',
      hovertext = paste("Scientific Name: ", df$scientificName,"\n",
                        "Vernacular Name: ", df$vernacularName,"\n",
                        "Date of observation: ",df$eventDate,"\n",
                        "Individual count: ", df$individualCount
      )
    )
  
  fig <- fig %>%
    layout(
      title = "Species observed in Poland over the years",
      mapbox = list(
        style = 'open-street-map',
        zoom =4.2,
        center = list(lon = 19, lat = 52))
      )
  
  fig <- fig %>%
    animation_slider(
      currentvalue = list(prefix = "YEAR ", font = list(color="red"))
    )
  
  return(fig)
}

#source("test_mapplot_animated.R")