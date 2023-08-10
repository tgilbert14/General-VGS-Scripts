--Move Events to new Site


Update Event
-- GUID for desired site to move sampling events to
SET FK_Site = X'd43e48c1471a814b8d3d247befda7f8f'
--Select * from Event
Where PK_Event IN (
Select PK_Event from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site ON Site.PK_Site = Event.FK_Site
where SiteID = '03-01-03-00306-008-C3'
and Date Like '%2022-10-28%'
)
