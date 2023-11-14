## setting directory to this source file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
## silence loading warning for sp/rgdal
"rgdal_show_exportToProj4_warnings"="none"

library(sf)
library(sp)
library(rgdal)

# read in shape file

shapefile <- rgdal::readOGR(dsn="D:/VGS - Deathstar II/GIS II/S_USA.Allotment", "S_USA.Allotment")
allotment<- as.data.frame(shapefile)

shapefile<- rgdal::readOGR(dsn="D:/VGS - Deathstar II/GIS II/S_USA.Pasture", "S_USA.Pasture")
pasture<- as.data.frame(shapefile)

shapefile <- rgdal::readOGR(dsn="D:/VGS - Deathstar II/GIS II/S_USA.Allotment/S_USA.Allotment.shp")
allotment<- as.data.frame(shapefile)
shapefile <- rgdal::readOGR(dsn="D:/VGS - Deathstar II/GIS II/S_USA.Pasture/S_USA.Pasture.shp")
pasture<- as.data.frame(shapefile)

View(allotment)
View(pasture)


# 
# # create a sample point
# point <- data.frame(lat = 42.36, lon = -71.06)
# coordinates(point) <- c("lon", "lat")
# proj4string(point) <- proj4string(shapefile)
# 
# # find what row the point falls in
# result <- over(point, shapefile)