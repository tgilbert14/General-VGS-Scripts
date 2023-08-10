Select FieldSymbol as 'Species Code', SpeciesQualifier as 'Species Qualifier', NewSynonym as 'New Code?', SpeciesName as 'Scientific Name', CommonName as 'Common Name', count(Sample.FK_Species) as 'Num Times Species Used' from Event
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event
INNER JOIN Species ON Species.PK_Species = Sample.FK_Species
INNER JOIN Site ON Site.PK_Site = Event.FK_Site
INNER JOIN dbo.AncestryCombinedPath on dbo.AncestryCombinedPath.PK_Site = Site.PK_Site
where Ancestry LIKE '%> Region 05 >%'
and EventName LIKE '%Freq%'
group by FieldSymbol, SpeciesQualifier, NewSynonym, SpeciesName, CommonName, Sample.FK_Species
--order by SpeciesName