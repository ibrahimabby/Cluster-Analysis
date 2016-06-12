library(fields)
library(ggmap)
require(gplots)

#Restaurants Analysis
odd<-read.csv("~/OrdersData.csv")
restaurants<-data.frame(odd$pickup_longitude, odd$pickup_latitude)
colnames(restaurants)<-c("lon", "lat")
center3 <- rev(sapply(restaurants, mean))

jogeva_map_g_str_m3 <- get_map(location = center3, zoom = 12)  # download map

ggmap(jogeva_map_g_str_m3, extent = "device", fullpage = TRUE) + geom_density2d(data = restaurants, 
aes(x = lon, y = lat), size = 0.3) + stat_density2d(data = restaurants, 
aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), size = 0.01, 
bins = 16, geom = "polygon") + scale_fill_gradient(low = "green", high = "red")
