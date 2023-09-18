--Looking at Protocols in use
select DISTINCT ProtocolName,FK_Type_Protocol, Count(DISTINCT PK_Protocol) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
Group by ProtocolName,FK_Type_Protocol
order by ProtocolName, FK_Type_Protocol
-- update statment

Update Protocol
Set ProtocolName = 'TAMU Sonora Range Monitoring'
Where ProtocolName = 'Sonora General'

Update Protocol
Set FK_Type_Protocol = X'22fb2b9ea5610f43aad87381adc8970a'
Where FK_Type_Protocol = X'55c0fa4475993246a48eb7aa4388e765'


-- Check groupNames 1
Select GroupName, Count(*) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
where ProtocolName = 'TAMU RLEM 415'
group by GroupName

-- Check groupNames 2
Select GroupName, Count(*) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
where ProtocolName = 'TAMU Sonora Range Monitoring'
group by GroupName


--Check EventNames 1
Select EventName, Count(*) from Protocol
FULL JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
FULL JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
where ProtocolName = 'TAMU Sonora Range Monitoring'
group by EventName

--Check EventNames 2
Select EventName, Count(*) from Protocol
FULL JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
FULL JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
where ProtocolName = 'TAMU RLEM 415'
group by EventName

--Check attributes??
--Create a new event with updated protocol/attributes and compare

Select ListItem, Description,List from typeList
where List = 'PROTOCOL' OR List = 'SURVEY'
order by ListItem

