--Looking at Protocols in use for specific area/folder
select DISTINCT ProtocolName,FK_Type_Protocol, Count(DISTINCT PK_Protocol) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
	--WHERE Ancestry LIKE '%> Region 06 > Rogue River%' 
Group by ProtocolName,FK_Type_Protocol
order by ProtocolName, FK_Type_Protocol
--order by FK_Type_Protocol

-- update statment [finding all Protocols/Events that using specific Protocol
-- in a specific folder schema (forest) and updating to current VGS5 version]

-- [ProtocolName] update
Update Protocol
Set ProtocolName = 'USFS R4 BTNF DIRH'
Where PK_Protocol IN (
select DISTINCT PK_Protocol from Protocol
--select DISTINCT ProtocolName,FK_Type_Protocol from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
WHERE ProtocolName = 'USFS R4 BTNF DIRH (3)')

select * from typeList
--where PK_Type = 'DC3AC9F5-EED5-4505-BD7D-3E139FDDA7C3'
where ListItem LIKE '%RTR Standard%'

Update typeList
set ListItem = 'USFS R6 Rogue River - Tally'
where ListItem = 'R6 Rogue River - Tally'
--where PK_Type = ''



-- other things
-- [FK_Type_Protocol] update
Update Protocol
Set FK_Type_Protocol = X'38fbc09e2646164fa85d304245fbff45'
--Select ProtocolName,FK_Type_Protocol  from Protocol
Where PK_Protocol IN (
select DISTINCT PK_Protocol from Protocol
--select DISTINCT ProtocolName,FK_Type_Protocol from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Site on Site.PK_Site = Event.FK_Site
INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
WHERE FK_Type_Protocol = X'66cb0d403f1118458dc4a420486be0a1'
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







--//Looking at data for specific site-date-method with error
SELECT DISTINCT * from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  WHERE SiteID LIKE '%03-04-07-00083-018-C6%' 
  AND Protocol.Date LIKE '%2020%'
  AND EventName LIKE '%Freq%'
  AND Transect = '1' AND SampleNumber = '5'
  --PK_Sample = X'0761f08190ee2b4596f8897438ae9c64'
  --ORDER by PK_Species
  

  