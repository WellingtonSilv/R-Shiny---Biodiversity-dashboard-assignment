library(data.table)
library(dplyr)

media <- fread('multimedia.csv',header=T,nrows=20)
occdf <- fread('occurence.csv',header=T,nrows=20)

media <- fread('multimedia.csv',header=T,
               select = c('CoreId','accessURI'))

colnames(media)[1] <- "id"

occdf <- fread('occurence.csv', header = T,
               select = c('id','vernacularName','scientificName',
                          'individualCount', 'longitudeDecimal',
                          'latitudeDecimal','countryCode','eventDate'),
               showProgress = T)

# filtering poland data
species_df <- occdf[occdf$countryCode=='PL']

# creating a column called year with the information
species_df$year <- year(species_df$eventDate)

# removing the countryCode column
species_df <- species_df[,-6]

remove(occdf)

# exporting the new dataset to .csv
write.table(species_df, 'species_df.csv',row.names = F, sep = ';', dec = '.')