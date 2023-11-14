## GLOBAL ----------------------------------------------------------------------
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(openxlsx)
library(tidyverse)
library(DBI)
library(RSQLite)
library(uuid)
## -----------------------------------------------------------------------------
## Function to move duplicate event data to another 'new' site for trouble shooting
## Brand new PK's for insert so like re-entering exact data again (no conflicts)
## To Use ->
## Create a new site and create an empty event first, then use function and
## input 'siteID' names and date of original event (2022-10-26)
## only does one event at a time as of now
## Tim Gilbert (2023-11-14)
## -----------------------------------------------------------------------------

duplicate.site.data <- function(old_site, new_site, date) {
  ## GUID creation function
  GUID <<- function(type = "pk", number_of_GUIDS = 1) {
    ## generate generic GUID
    g <- uuid::UUIDgenerate(n = number_of_GUIDS)
    ## formatting based on type of GUID
    if (type == "pk") { ## for pk's
      g2 <- paste0(
        "X'", substr(g, 1, 8), substr(g, 10, 13), substr(g, 15, 18),
        substr(g, 20, 23), substr(g, 25, 36), "'"
      )
    }
    if (type == "sp") { ## for species
      ## Other and Ground Cover Lists Supported - Need to add OT or G in front
      g2 <- toupper(paste0("_$", substr(g, 1, 8), substr(g, 10, 11), "'"))
    }
    return(g2)
  }
  
  ## SQL local Connection from R to local VGS5
  db_loc <- "C:/ProgramData/VGSData/VGS50.db"
  mydb <- dbConnect(RSQLite::SQLite(), dbname = db_loc)
  
  ## get protocol event names
  sql_q_eventNames <- paste0("select Distinct EventName from Sample
INNER JOIN Event ON Event.PK_Event = Sample.FK_Event
INNER JOIN Site on Site.PK_Site = Event.FK_Site
where SiteID = '", old, "'")
  ## event names with data
  vgs_eventNames <- dbGetQuery(mydb, sql_q_eventNames)
  
  ## set site name variables
  new <- new_site
  old <- old_site
  
  ## loop through each form to add data
  each_form <- 1
  while (each_form < nrow(vgs_eventNames) + 1) {
    ## Query for getting old data for each form
    sql_query2 <- paste0("select quote(PK_Sample), quote(Fk_Event), FK_Species, Transect, SampleNumber, Element, FieldSymbol, nValue from Sample
INNER JOIN Event ON Event.PK_Event = Sample.FK_Event
INNER JOIN EventGroup ON EventGroup.PK_EventGroup = Event.FK_EventGroup
INNER JOIN Protocol on Protocol.PK_Protocol = EventGroup.FK_Protocol
INNER JOIN Site on Site.PK_Site = Event.FK_Site
where SiteID = '", old, "' and EventName = '", vgs_eventNames[[1]][each_form], "' and Protocol.Date LIKE '%", date, "%'")
    ## pk samples data to move to new site
    vgs_data <- dbGetQuery(mydb, sql_query2)
    
    ## new event 'new_site' - getting pk_event for where to move to
    new_q <- paste0("select quote(PK_Event), EventName from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
where SiteID = '", new, "' and EventName = '", vgs_eventNames[[1]][each_form], "'")
    ## pk_event info
    vgs_info <- dbGetQuery(mydb, new_q)
    
    new_fk_event <- vgs_info$`quote(PK_Event)`
    
    ## go through each sample line and insert into new site
    w <- 1
    while (w < nrow(vgs_data) + 1) {
      sql_insert <- paste0(
        "Insert into Sample (PK_Sample, Fk_Event, FK_Species, Transect, SampleNumber, Element, FieldSymbol, nValue, SyncKey, SyncState) VALUES (",
        GUID(), ",", new_fk_event, ",'", vgs_data$FK_Species[w], "',", vgs_data$Transect[w], ",", vgs_data$SampleNumber[w], ",",
        vgs_data$Element[w], ",'", vgs_data$FieldSymbol[w], "',", vgs_data$nValue[w], ", 33, 1)"
      )
      dbExecute(mydb, sql_insert)
      w <- w + 1
    }
    ## move on to next form
    each_form <- each_form + 1
  }
  
  ## disconnect at end
  if (each_form == nrow(vgs_eventNames) + 1) {
    dbDisconnect(mydb)
  }
}
## end of function

duplicate.site.data(old_site = "new_site_sal", new_site = "new_new", date = "2023")
