# this function plots species observed over the years on a not animated map plot
mapplot <- function(data = NULL, inputs = NULL){

  # selecting the species by scientific or vernacular names
  data = data[data$scientificName %in% inputs | data$vernacularName %in% inputs]
  
  fig <- data
  
  fig <- fig %>%
    plot_ly(
      lat = ~latitudeDecimal,
      lon = ~longitudeDecimal,
      size = ~individualCount,
      fill = ~'',
      marker = list(color=seq(1,1000), colorscale='Viridis',
                    reversescale =T, sizemode = 'diameter'),
      type = 'scattermapbox',
      mode = 'markers',
      hovertext = paste("Scientific Name: ", data$scientificName,"\n",
                        "Vernacular Name: ", data$vernacularName,"\n",
                        "Date of observation: ",data$eventDate,"\n",
                        "Individual count: ", data$individualCount
                        )
      )
  
  fig <- fig %>%
    layout(
      title = "Selected species observed in Poland from 1984 to 2022",
      mapbox = list(
        style = 'open-street-map',
        zoom =4,
        center = list(lon = 19, lat = 52))) 
  
  fig
}

#source("test_mapplot.R")

