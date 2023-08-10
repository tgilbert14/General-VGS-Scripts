--Looking at Protocols in use for specific area/folder
select DISTINCT ProtocolName,FK_Type_Protocol, Count(DISTINCT PK_Protocol) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
	WHERE Ancestry LIKE '%> Region 03 > Tonto National Forest > %' 
Group by ProtocolName,FK_Type_Protocol
order by ProtocolName, FK_Type_Protocol
--order by FK_Type_Protocol

-- update statment [finding all Protocols/Events that using specific Protocol
-- in a specific folder schema (forest) and updating to current VGS5 version]

-- [ProtocolName] update
Update Protocol
Set ProtocolName = 'USFS R3 Tonto Standard'
Where PK_Protocol IN (
select DISTINCT PK_Protocol from Protocol
--select DISTINCT ProtocolName,FK_Type_Protocol from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
	WHERE Ancestry LIKE '%> Region 03 > Tonto National Forest > %'
	AND ProtocolName = 'RTR Standard'
)

select * from typeList
--where PK_Type = 'DC3AC9F5-EED5-4505-BD7D-3E139FDDA7C3'
where ListItem LIKE '%RTR Standard%'

Update typeList
set ListItem = 'USFS R3 Tonto Standard'
where ListItem = 'RTR Standard'
--where PK_Type = ''



-- other things
-- [FK_Type_Protocol] update
Update Protocol
Set FK_Type_Protocol = 'DC3AC9F5-EED5-4505-BD7D-3E139FDDA7C3'
--Select ProtocolName,FK_Type_Protocol  from Protocol
Where PK_Protocol IN (
select DISTINCT PK_Protocol from Protocol
--select DISTINCT ProtocolName,FK_Type_Protocol from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
	WHERE Ancestry LIKE '%> Region 03 > Tonto National Forest > %'
	AND FK_Type_Protocol = 'DC3AC9F5-EED5-4505-BD7D-3E139FDDA7C3'
)

--DC3AC9F5-EED5-4505-BD7D-3E139FDDA7C3

select DISTINCT SiteID, Protocol.Date, ProtocolName from Protocol
--select DISTINCT ProtocolName,FK_Type_Protocol from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
	WHERE Ancestry LIKE '%%'
	AND (FK_Type_Protocol = '5048652A-5284-4033-8EBE-7D29B2439B24' OR
	FK_Type_Protocol = 'A5EF4CC4-B2A4-4BD0-9116-1041765484B0')

