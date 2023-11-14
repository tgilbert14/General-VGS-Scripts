setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
## GLOBAL ----------------------------------------------------------------------
library(openxlsx)
library(tidyverse)
library(DBI)
library(RSQLite)
library(uuid)
## GUID creation function ------------------------------------------------------
GUID <<- function(type='pk', number_of_GUIDS=1) {
  ## generate generic GUID
  g<-uuid::UUIDgenerate(n=number_of_GUIDS)
  ## formatting based on type of GUID
  if (type == 'pk') { ## for pk's
    g2<-paste0("X'",substr(g,1,8),substr(g,10,13),substr(g,15,18),
               substr(g,20,23),substr(g,25,36),"'")
  }
  if (type == 'sp') { ## for species
    ## Other and Ground Cover Lists Supported - Need to add OT or G in front
    g2<-toupper(paste0("_$",substr(g,1,8),substr(g,10,11),"'"))
  }
  return(g2)
}
## SQL local Connection from R to local VGS5
db_loc <- "C:/ProgramData/VGSData/VGS50.db"
mydb <- dbConnect(RSQLite::SQLite(), dbname = db_loc)

## Query
sql_query <- paste0("select quote(PK_Sample) from Sample")
## pk samples
vgs_samples <- dbGetQuery(mydb, sql_query)
## Updating all Pk_Sample GUIDS
a=1
while (a < nrow(vgs_samples)+1) {
  q<- paste0("Update Sample Set PK_Sample = ",GUID()," Where PK_Sample = ",vgs_samples[[1]][a])
  dbExecute(mydb, q)
  a=a+1
}
## make a new Protocol and merge events into it (new PK's created)
## get rid of any contacts to avoid errors

dbDisconnect(mydb)
