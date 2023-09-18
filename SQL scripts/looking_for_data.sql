

Select DISTINCT SiteID, Ancestry AS 'Folder Path' from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
where PK_EventGroup = '24f3e856-adca-4f2e-94ea-007950c25016'
and Ancestry LIKE '%Apache-sit%'


Select DISTINCT SiteID, SUBSTRING(Ancestry, LEN(Ancestry)-80,LEN(Ancestry)) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
where PK_EventGroup = '24f3e856-adca-4f2e-94ea-007950c25016'
and Ancestry LIKE '%Apache-sit%'

