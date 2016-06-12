library(fields)
library(ggmap)
require(gplots)

od<-read.csv("~/OrdersData.csv")
#orderdata<-data.frame(od)

oddf1<-data.frame(od$delivered_latitude, od$delivered_longitude)
oddf2<-data.frame(od$pickup_latitude, od$pickup_longitude)

colnames(oddf1)<-c("dlat", "dlong")
colnames(oddf2)<-c("plat", "plong")
#head(x)
x<-as.matrix(oddf1)
y<-as.matrix(oddf2)

rawdata <- data.frame(as.numeric(od$delivered_longitude), as.numeric(od$delivered_latitude))
names(rawdata) <- c("lon", "lat")
center <- rev(sapply(rawdata, mean))

plon = orderdata$pickup_longitude
plat = orderdata$pickup_latitude
pick<-data.frame(plon, plat)
head(pick)
colnames(pick)<-c("lon", "lat")

dlat = orderdata$delivered_latitude
dlon = orderdata$delivered_longitude
del<-data.frame(dlon, dlat)
colnames(del)<-c("lon", "lat")

coors <- data.frame(del)

#distance matrix
dist <- rdist.earth(coors,miles = F,R=6371)

#clustering
as.dist(dist)
fit <- function(dist)hclust(as.dist(dist), method = "single")
heatmap.2(x, trace="none", hclustfun=fit, scale="column")

fit1 <- hclust(as.dist(dist), method = "single")
clusters <- cutree(fit1,h = 57)

jogeva_map_g_str_m <- get_map(location = center, zoom = 12)  # download map

ggmap(jogeva_map_g_str_m, extent = "device") + geom_density2d(data = rawdata, 
aes(x = lon, y = lat), size = 0.3) + stat_density2d(data = rawdata, 
aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), size = 0.01, 
bins = 16, geom = "polygon") + scale_fill_gradient(low = "green", high = "red")
