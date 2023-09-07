--Looking at Protocols in use
select DISTINCT ProtocolName,FK_Type_Protocol, Count(DISTINCT PK_Protocol) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
Group by ProtocolName,FK_Type_Protocol
order by ProtocolName, FK_Type_Protocol
-- update statment
Update Protocol
Set ProtocolName = 'USFS R4 Range Monitoring'
Where ProtocolName = 'USFS R4'

Update Protocol
Set FK_Type_Protocol = X'22fb2b9ea5610f43aad87381adc8970a'
Where FK_Type_Protocol = X'55c0fa4475993246a48eb7aa4388e765'


-- Check groupNames
Select GroupName, Count(*) from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
where ProtocolName = 'USFS R4 Range Monitoring'
group by GroupName

--Check attributes??
--Create a new event with updated protocol/attributes and compare

Select ListItem, Description,List from typeList
where List = 'PROTOCOL' OR List = 'SURVEY'
order by ListItem

