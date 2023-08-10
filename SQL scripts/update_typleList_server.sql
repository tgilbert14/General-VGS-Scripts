--//Looking at Protocols in use\\--
select DISTINCT ProtocolName,FK_Type_Protocol, Count(DISTINCT PK_Protocol) AS Count from Protocol
 INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
 Group by ProtocolName,FK_Type_Protocol
 order by ProtocolName, FK_Type_Protocol, Count


--//Potocols in type list but no data on server using them\\--
select ListItem, PK_Type from typeList
 where PK_Type NOT IN
 (select DISTINCT FK_Type_Protocol from Protocol
 INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol)
 and (List = 'PROTOCOL' OR List = 'SURVEY')
 order by ListItem
 
 --//Delete from typelist statement - there should be no data associated with protocol
--Delete from typeList
--where ListItem = 'Sage Grouse HAF - Lek'
--where ListItem LIKE '%newSurveyOptions%'
--and PK_Type = 'F587F636-FF15-47A4-AF5C-00D326B6F257'

Select PK_Type, ListItem, IsDefault, Active, SyncState from Typelist
where List = 'PROTOCOL' OR List = 'SURVEY'
order by ListItem

--//Update Protocol Statments\\--
--Update Protocol
--Set ProtocolName = 'USFS R4 Range Monitoring'
--Where ProtocolName = 'USFS R4'

--Update Protocol
--Set FK_Type_Protocol = X'22fb2b9ea5610f43aad87381adc8970a'
--Where FK_Type_Protocol = X'55c0fa4475993246a48eb7aa4388e765'