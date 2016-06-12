library(fields)
library(ggmap)
require(gplots)

#Rider Analysis
ld<-read.csv("G:/Shadowfox/DATA_NEW/LocationData.csv")

rawdata1 <- data.frame(as.numeric(ld$latitude), as.numeric(ld$longitude))
head(rawdata1)
names(rawdata1) <- c("lat", "lon")
center1 <- rev(sapply(rawdata1, mean))

jogeva_map_g_str_m2 <- get_map(location = center1, zoom = 12)  # download map

ggmap(jogeva_map_g_str_m2, extent = "device", fullpage = TRUE) + geom_density2d(data = rawdata1, 
aes(x = lon, y = lat), size = 0.3) + stat_density2d(data = rawdata1, 
aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), size = 0.01, 
bins = 16, geom = "polygon") + scale_fill_gradient(low = "blue", high = "black")

#Rider Routing Information
from <- "basavanagudi, bangalore"
to <- "jayanagar, bangalore"
route_df1 <- route(from, to, structure = "route", mode = "driving")
qmap("bangalore", zoom = 13) +
  geom_path(
    aes(x = lon, y = lat),  colour = "red", size = 1.5,
    data = route_df1, lineend = "round"
  )

from <- "jayanagar, bangalore"
to <- "koramangala, bangalore"
route_df2 <- route(from, to, structure = "route")
qmap("bangalore", zoom = 13) +
  geom_path(
    aes(x = lon, y = lat),  colour = "red", size = 1.5,
    data = route_df2, lineend = "round"
  )
