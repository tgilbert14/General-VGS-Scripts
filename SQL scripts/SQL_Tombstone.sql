
--// Clear tombstone \\--
-- this should only be used for troubleshooting databases --
delete from tombstone





select * from siteClass
where CK_ParentClass = X'C8A45B1FC03B18418A0F5295CD62B072'

select * from siteClasslink
where FK_SiteClass IN (

select * from site
inner join SiteClassLink on siteClassLink.FK_Site = site.PK_Site
inner join SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
--where CK_ParentClass = X'C8A45B1FC03B18418A0F5295CD62B072'
)


select * from SiteClassLink
inner join SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass

select * from site
inner join event on event.FK_Site = site.PK_Site

SELECT * from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
INNER JOIN Site ON Site.PK_Site = Event.FK_Site

--select * from EventGroup
Delete from Sample
Where PK_Sample IN(
SELECT DISTINCT PK_Sample from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site ON Site.PK_Site = Event.FK_Site
where PK_Site = X'4C9070A75BAF3348837D2AC7455173B3')

delete from sample
where PK_Sample IN (
SELECT DISTINCT PK_Sample from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
INNER JOIN Site ON Site.PK_Site = Event.FK_Site
where PK_Site = X'328CB4CF0D4A874EA9A65A4354152087')

Delete from Event
Where PK_Event IN(
SELECT DISTINCT PK_Event from Protocol  
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
where PK_Site = X'328CB4CF0D4A874EA9A65A4354152087'
)

Delete from EventGroup 
Where PK_EventGroup IN(
SELECT DISTINCT PK_EventGroup from Protocol  
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
where PK_Site = X'B3D811C15954074CB57D67BCC66EA318'
)

Delete from SiteClassLink
Where PK_SiteClassLink IN(
SELECT * from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass
where SiteID = X'B3D811C15954074CB57D67BCC66EA318'
)

select * from Site
where PK_Site = X'B3D811C15954074CB57D67BCC66EA318'

delete from Site
where PK_Site = X'B3D811C15954074CB57D67BCC66EA318')