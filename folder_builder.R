## setting directory to this source file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
## silence loading warning for sp/rgdal
"rgdal_show_exportToProj4_warnings"="none"
## GLOBAL ----------------------------------------------------------------------
library(openxlsx)
library(tidyverse)
library(DBI)
library(RSQLite)
library(uuid)
library(sf)
library(sp)
library(rgdal)


## SQL local Connection from R to local VGS5
db_loc <- "C:/ProgramData/VGSData/VGS50.db"
mydb <- dbConnect(RSQLite::SQLite(), dbname = db_loc)

## call R file to use created VGS functions for R
source("C:/Users/tsgil/OneDrive/Documents/VGS/Functions/VGS_functions_R.R")

create_schema <- function(Region) {
  
}

# read in shape file
# shapefile <- rgdal::readOGR(dsn="D:/VGS - Deathstar II/GIS II/S_USA.Allotment", "S_USA.Allotment")
# allotment<- as.data.frame(shapefile)

#shapefile<- rgdal::readOGR(dsn="D:/VGS - Deathstar II/GIS II/S_USA.Pasture", "S_USA.Pasture")
shapefile<- rgdal::readOGR(dsn="E:/VGS - Deathstar II/GIS II/S_USA.Pasture", "S_USA.Pasture")
pasture<- as.data.frame(shapefile)

## must have acres to be created - but keeping closed pastures for now
pasture<- pasture %>% 
  filter(TOTAL_ACRE != 0)

## format naming convention
pasture_w_codes<- pasture %>% 
  dplyr::mutate('USFS_Code' = paste0(substr(ADMIN_ORG,1,2),"-",
                                     substr(ADMIN_ORG,3,4),"-",
                                     substr(ADMIN_ORG,5,6),"-",
                                     ALLOTMENT1,"-",PASTURE_NU))
## format columns for metadata for folders
p<- pasture_w_codes %>% 
  dplyr::mutate('Region_Filter' = paste0(substr(ADMIN_ORG,1,2))) %>% 
  dplyr::mutate('Forest_Number' = paste0(substr(ADMIN_ORG,3,4))) %>%
  dplyr::mutate('RD_Number' = paste0(substr(ADMIN_ORG,5,6))) %>% 
  dplyr::mutate('Ranger District' = paste0(ADMIN_ORG_)) %>%
  dplyr::mutate('Allotment' = paste0(ALLOTMENT_, " Allotment")) %>%
  dplyr::mutate('Pasture' = paste0(PASTURE_NA, " Pasture"))

pasture_data<- p %>% 
  select(ADMIN_ORG_, RD_Number, Allotment, ALLOTMENT1, Pasture, PASTURE_NU, USFS_Code, Region_Filter)

## filter to region
pasture_data <- pasture_data %>% 
  filter(Region_Filter == Region)

## Get rid of troublesome characters
pasture_data$ADMIN_ORG_<- gsub(pattern = "&", replacement = "", pasture_data$ADMIN_ORG_)
pasture_data$Allotment<- gsub(pattern = "&", replacement = "", pasture_data$Allotment)
pasture_data$Pasture<- gsub(pattern = "&", replacement = "", pasture_data$Pasture)

pasture_data$ADMIN_ORG_<- gsub(pattern = "/", replacement = "-", pasture_data$ADMIN_ORG_)
pasture_data$Allotment<- gsub(pattern = "/", replacement = "-", pasture_data$Allotment)
pasture_data$Pasture<- gsub(pattern = "/", replacement = "-", pasture_data$Pasture)

pasture_data$ADMIN_ORG_<- gsub(pattern = "#", replacement = "", pasture_data$ADMIN_ORG_)
pasture_data$Allotment<- gsub(pattern = "#", replacement = "", pasture_data$Allotment)
pasture_data$Pasture<- gsub(pattern = "#", replacement = "", pasture_data$Pasture)

pasture_data$ADMIN_ORG_<- str_to_title(pasture_data$ADMIN_ORG_)
pasture_data$Allotment<- str_to_title(pasture_data$Allotment)
pasture_data$Pasture<- str_to_title(pasture_data$Pasture)

#View(pasture_data)

## replace repeats - Allotment and Pasture
replacements_a <- grep("Allotment Allotment", pasture_data$Allotment)
replacements_p <- grep("Pasture Pasture", pasture_data$Pasture)

## Getting rid of doubles -------
i=1
while (i < length(replacements_a)+1) {
  pasture_data[replacements_a,][,3][i]<-
    paste0(substr(pasture_data[grep("Allotment Allotment", pasture_data$Allotment),][,3][i],1,
           ## end of sub-string - get rid of extra allotment
           nchar(pasture_data[grep("Allotment Allotment", pasture_data$Allotment),][,3][i])-10))
           print(paste0(i," - Updated ", pasture_data$Allotment[i]))
  i=i+1
}
## replace repeats - Pasture
i=1
while (i < length(replacements_p)+1) {
  pasture_data[replacements_p,][,5][i]<-
    paste0(substr(pasture_data[grep("Pasture Pasture", pasture_data$Pasture),][,5][i],1,
           ## end of sub-string - get rid of extra pasture
           nchar(pasture_data[grep("Pasture Pasture", pasture_data$Pasture),][,5][i])-8))
            print(paste0(i," - Updated ", pasture_data$Pasture[i]))
  i=i+1
}
## ---------------

View(pasture_data)
#View(p)

## In progress --->
x=1
while (x < nrow(pasture_data)+1) {
  
}
names(pasture_data)
temp<- pasture_data %>% 
  select(ADMIN_ORG_, RD_Number)
RDs<- unique(temp)
View(RDs)





## RD first ->
## Query to get Site Schema for pasture
sql_query_pastures <- paste0("INSERT INTO SiteClass (PK_SiteClass, CK_ParentClass, ClassID, ClassName, SyncKey, SyncState) 
                             VALUES (",GUID(1),"X'11111111111111111111111111111111'")
## table from VGS local .db
vgs_pastures <- dbGetQuery(mydb, sql_query_pastures)



## closing SQL connection
DBI::dbDisconnect(mydb)
closeAllConnections()
