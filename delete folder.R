## setting directory to this source file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
## GLOBAL ----------------------------------------------------------------------
library(openxlsx)
library(tidyverse)
library(DBI)
library(RSQLite)
library(uuid)

delete_admin_folder <- function(admin_folder_name) {
  ## SQL local Connection from R to local VGS5
  db_loc <- "C:/ProgramData/VGSData/VGS50.db"
  mydb <- dbConnect(RSQLite::SQLite(), dbname = db_loc)
  
  ## Query to get Site Schema for pasture
  sql_query_pastures <- paste0("SELECT quote(PK_site) AS PK_Site, quote(Ck_ParentClass) AS Allotment_PK, siteID, ClassName AS PASTURE_NA from Site
inner join siteClassLink on siteClassLink.FK_Site = Site.PK_Site
inner join siteclass on siteclass.PK_SiteClass = siteClassLink.FK_SiteClass
where ClassName LIKE '%Pasture%'")
  ## table from VGS local .db
  vgs_pastures <- dbGetQuery(mydb, sql_query_pastures)
  
  ## Query to get Site Schema for allotment
  sql_query_allotments <- paste0("SELECT quote(PK_siteClass) AS Allotment_PK, ClassName AS ALLOTMENT_, quote(Ck_ParentClass) AS RD_PK from SiteClass
where ClassName LIKE '%Allotment%'")
  ## table from VGS local .db
  vgs_allotments <- dbGetQuery(mydb, sql_query_allotments)
  vgs_schema <- left_join(vgs_pastures, vgs_allotments, by = "Allotment_PK")
  
  ## Query to get Site Schema for allotment
  sql_query_RD <- paste0("SELECT quote(PK_siteClass) AS RD_PK, ClassName AS ADMIN_ORG_ from SiteClass")
  ## table from VGS local .db
  vgs_RD <- dbGetQuery(mydb, sql_query_RD)
  vgs_schema_2 <- left_join(vgs_schema, vgs_RD, by = "RD_PK")
  View(vgs_schema_2)
  
  ## sites to be deleted
  delete_these <- vgs_schema_2 %>% 
    filter(ADMIN_ORG_ == admin_folder_name)
  View(delete_these)
  
  tables <- c("Sample", "Event")
  pk <- c("PK_Sample", "PK_Event")
  i=1
  x=1
  while (x < length(tables)+1) {
    ## delete sites where PK_Site is present
    while  (i < nrow(delete_these)+1) {
      ## delete sample and event data
      delete_query<- paste0("delete from ",tables[x]," where ",pk[x]," IN (
SELECT DISTINCT ",pk[x]," from Protocol  
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol 
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup 
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event 
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site 
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass 
where PK_Site = ",delete_these$PK_Site[i],")")
      dbExecute(mydb, delete_query)
      ## delete site
      delete_site<- paste0("delete from Site 
where PK_Site = ",delete_these$PK_Site[i])
      dbExecute(mydb, delete_site)
      
      i=i+1
    }
    x=x+1
  }
}

delete_admin_folder(admin_folder_name = "Minidoka Ranger District")


## clean up database

## get rid of orphan data / clear tombstone / etc.



## closing SQL connection
DBI::dbDisconnect(mydb)
closeAllConnections()
