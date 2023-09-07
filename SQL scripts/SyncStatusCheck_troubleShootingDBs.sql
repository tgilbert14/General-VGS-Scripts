
--// Shows if protocol/eventgroup/event have syncState=1 (local) --\\
--// while site/folder/links they are with have syncState=0 (cloud) --\\
SELECT DISTINCT SiteID, ProtocolName, Protocol.Date from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN SiteClassLink ON SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
  --// select where parent site/parent folder/link are syncable
  where (Site.SyncState = 0 OR SiteClass.SyncState = 0 OR SiteClassLink.SyncState = 0)
  --// and the event is not
  and (Protocol.SyncState = 1 OR EventGroup.SyncState = 1 OR Event.SyncState = 1)

--// Update Protocol
Update Protocol
Set SyncState = 0
Where PK_Protocol IN (
SELECT DISTINCT PK_Protocol from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN SiteClassLink ON SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
  where (Site.SyncState = 0 OR SiteClass.SyncState = 0 OR SiteClassLink.SyncState = 0)
  and (Protocol.SyncState = 1 OR EventGroup.SyncState = 1 OR Event.SyncState = 1))

--// Update EventGroup
Update EventGroup
Set SyncState = 0
Where PK_EventGroup IN (
SELECT DISTINCT PK_EventGroup from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN SiteClassLink ON SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
  where (Site.SyncState = 0 OR SiteClass.SyncState = 0 OR SiteClassLink.SyncState = 0)
  and (Protocol.SyncState = 1 OR EventGroup.SyncState = 1 OR Event.SyncState = 1))
  
--// Update Event
Update Event
Set SyncState = 0
Where PK_Event IN (
SELECT DISTINCT PK_Event from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN SiteClassLink ON SiteClassLink.FK_Site = Site.PK_Site
  INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
  where (Site.SyncState = 0 OR SiteClass.SyncState = 0 OR SiteClassLink.SyncState = 0)
  and (Protocol.SyncState = 1 OR EventGroup.SyncState = 1 OR Event.SyncState = 1))