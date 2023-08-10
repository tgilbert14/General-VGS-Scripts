INSERT INTO SpList (PK_SpList, FK_SubType, ListName, SpFilter, Active, SyncKey, SyncState) VALUES(
'1fa231c4-be95-11ed-8000-b5648ec8bd43',X'919499aa3e33e0419852dea440864466','BedRock_Kind_232','OT',1,30,4)


INSERT INTO SpList (PK_SpList, FK_SubType, ListName, SpFilter, Active, SyncKey, SyncState) VALUES(
'1fa231c4-be95-11ed-8000-b5648ec8bd43',X'919499aa3e33e0419852dea440864466','BedRock_Kind_232','OT',1,30,4)


Select PK_Species, CommonName, SpeciesName From Species
Where List = 'OT'


select sample.* from sample
inner join event on event.PK_Event = sample.FK_Event
inner join eventgroup on eventgroup.PK_EventGroup = event.FK_EventGroup
inner join protocol on protocol.PK_Protocol = eventgroup.FK_Protocol
where EventName LIKE '%1%'


select * from sample
inner join event on event.PK_Event = sample.FK_Event
inner join eventgroup on eventgroup.PK_EventGroup = event.FK_EventGroup
inner join protocol on protocol.PK_Protocol = eventgroup.FK_Protocol
where EventName LIKE '%Point Ground%'
and FK_Species = 'VERBE'

select * from site
where PK_Site = X'00e3196ab096e84fbbc496630763095d'



--// If here, Transect and Sample# needs to be switched
SELECT DISTINCT * from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
  WHERE Ancestry LIKE '%Cypress Pasture%' 
  AND Transect <> 0 AND Transect <> 1 
  AND EventName LIKE '%Clipping%'
  Order by Site.SiteID


UPDATE Sample
SET Transect = SampleNumber, SampleNumber = Transect
WHERE PK_Sample IN
  (SELECT DISTINCT PK_Sample from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
  WHERE Ancestry LIKE '%Cypress Pasture%' 
  AND Transect <> 0 AND Transect <> 1
  AND EventName LIKE '%Clipping%')
  
select DDLat, DDLong, SiteID from Locator
inner join Site on Site.PK_Site = Locator.FK_Site
  