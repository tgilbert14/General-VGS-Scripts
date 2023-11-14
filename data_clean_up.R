
## Clears out all syncable data and data links and clears tombstone so
## data not deleted from sites -> used to update sync states / troubleshoot errors

## setting directory to this source file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
## GLOBAL ######################################################################
library(openxlsx)
library(tidyverse)
library(DBI)
library(RSQLite)
#library(uuid)

Hex <- function(vgs5_guid) {
  ## converting to hex
  guid<- vgs5_guid
  # Remove curly braces and hyphens
  guid <- gsub("[{}-]", "", guid)
  guid
  # Convert to hexadecimal
  hex_guid <- tolower(paste0(substr(guid, 7, 8), substr(guid, 5, 6), substr(guid, 3, 4),
                             substr(guid, 1, 2),substr(guid,11,12),substr(guid,9,10),
                             substr(guid,15,16),substr(guid,13,14),
                             gsub("-", "", substr(guid, 17, 36))))
  hex_guid <- paste0("X'",hex_guid,"'")
  # Return the result
  return(hex_guid)
}

## SQL local Connection from R to local VGS5
db_loc <- "C:/ProgramData/VGSData/VGS50.db"
mydb <- dbConnect(RSQLite::SQLite(), dbname = db_loc)

##delete all syncable folder links
del_syncable_folders<- "delete from SiteClassLink
where PK_SiteClassLink IN (
  select PK_SiteClassLink from SiteClassLink
  where SyncState = 0)"

##delete all local folder links
##delete from SiteClassLink
##where PK_SiteClassLink IN (
  ##select PK_SiteClassLink from SiteClassLink
  ##where SyncState = 1)

## Use to delete unassigned sample data
del_sa<- "delete from sample
where PK_Sample NOT IN (
  select PK_Sample from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event  
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
  INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)"

## Use to delete unassigned inq data
del_inq<- "delete from Inquiry
where PK_Inquiry NOT IN (
  select PK_Inquiry from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Inquiry ON Inquiry.FK_Event = Event.PK_Event  
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
  INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)"

## Use to delete unassigned Event Data
del_ev<- "Delete from Event
Where PK_Event NOT IN(
  SELECT DISTINCT PK_Event from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup  
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
  INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)"

##checking event groups
del_ev_g<- "Delete from EventGroup
Where PK_EventGroup NOT IN(
  SELECT DISTINCT PK_EventGroup from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup)"

## then use this to delete unassined sites
del_s<- "delete from site
where PK_Site NOT IN (
  select DISTINCT PK_Site from Site
  INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)"

## checking Orphan links
del_scl<- "delete from SiteClassLink
where PK_SiteClassLink NOT IN (
  select DISTINCT PK_SiteClassLink from Site
  INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)"

del_pr<- "Delete from Protocol
Where PK_Protocol NOT IN(
  SELECT DISTINCT PK_protocol from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup)"

##delete protocols not in use from typeList
## Use to delete unassigned sample data
del_tl<- "delete from typeList
WHERE List = 'PROTOCOL'
AND PK_Type NOT IN (
  select DISTINCT FK_Type_Protocol from Protocol
  INNER JOIN typeList ON typeList.PK_Type = Protocol.FK_Type_Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event  
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
  INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)"


## checking Orphan links - Contact
del_cl<- "delete from ContactLink
where PK_ContactLink NOT IN (
  select DISTINCT PK_ContactLink from Contact
  INNER JOIN ContactLink on ContactLink.FK_Contact = Contact.PK_Contact)"

## getting rid of unused contacts
del_c<- "delete from contact
where PK_Contact NOT IN (
  select DISTINCT PK_Contact from Contact
  RIGHT JOIN ContactLink on ContactLink.FK_Contact = Contact.PK_Contact)"

## getting rid of empty folders (syncable folders) which are not the root
del_sc<- paste0("Delete from SiteClass
Where PK_SiteClass IN (
  select DISTINCT PK_SiteClass from siteClass
  left join siteClassLink on SiteClassLink.FK_SiteClass = SiteClass.PK_SiteClass
  where SiteClass.SyncState = 0
  and Ck_ParentClass IN (
      select Pk_SiteClass from SiteClass
      )
)")


del_ts<- "delete from tombstone"

DBI::dbSendStatement(mydb, del_syncable_folders)
DBI::dbSendStatement(mydb, del_sa)
DBI::dbSendStatement(mydb, del_inq)
DBI::dbSendStatement(mydb, del_ev)
DBI::dbSendStatement(mydb, del_ev_g)
DBI::dbSendStatement(mydb, del_s)
DBI::dbSendStatement(mydb, del_scl)
DBI::dbSendStatement(mydb, del_pr)
DBI::dbSendStatement(mydb, del_tl)
DBI::dbSendStatement(mydb, del_cl)
DBI::dbSendStatement(mydb, del_c)
DBI::dbSendStatement(mydb, del_sc)
DBI::dbSendStatement(mydb, del_ts)

DBI::dbDisconnect(mydb)
closeAllConnections()
