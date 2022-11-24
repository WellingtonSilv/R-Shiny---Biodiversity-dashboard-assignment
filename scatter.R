# this function plots species observed over the years on a not animated scatter plot with all selected 
scatter <- function(data = NULL, inputs = NULL){
  
  # selecting the species by scientific or vernacular names
  df <- data[data$scientificName %in% inputs | data$vernacularName %in% inputs]
  
  fig <- df
  
  fig <- fig %>%
    plot_ly(
      x = ~year, 
      y = ~individualCount, 
      size = ~individualCount, 
      fill = ~'',
      #marker = list(sizemode = "diameter"),
      color = ~scientificName, 
      text = ~scientificName,
      hovertext = paste("Scientific Name: ", df$scientificName,"\n",
                        "Vernacular Name: ", df$vernacularName,"\n",
                        "Date of observation: ",df$eventDate,"\n",
                        "Individual count: ", df$individualCount
      ),
      type = 'scatter',
      mode = 'markers'
      )
  
  fig <- fig %>% layout(
    title = "Selected species observed over the years",
    showlegend = TRUE
  )
  
  return(fig)
}

#source("test_scatter.R")