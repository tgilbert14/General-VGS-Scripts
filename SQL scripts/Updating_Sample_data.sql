SET Transect = SampleNumber, SampleNumber = Transect
--select * from Sample
WHERE Sample.PK_Sample IN
  (SELECT DISTINCT PK_Sample from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  INNER JOIN AncestryCombinedPath ON AncestryCombinedPath.PK_Site = Site.PK_Site
  WHERE Ancestry LIKE '%> Region 03 > Tonto National%' 
  AND Transect <> 0 AND Transect <> 1
  AND EventName LIKE '%Clipping%')
  
Update SpList
Set FK_SubType = X'3b690e6214ae7443ba9fda273cff1752'
--select * from SpList
where ListName LIKE '%plant list%'

--DI_SA9NKN5S6T

SELECT DISTINCT * from Protocol
  INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol
  INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
  INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
  INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
  --INNER JOIN Site ON Site.PK_Site = Event.FK_Site
  WHERE PK_Species = 'DI_SA9NKN5S6T'
  
  Select * from SpListLink
  inner join species on species.PK_Species = spListLink.FK_Species
  inner join spList on spList.PK_SpList = spListLink.FK_SpList
  where FK_Species = 'DI_SA9NKN5S6T'