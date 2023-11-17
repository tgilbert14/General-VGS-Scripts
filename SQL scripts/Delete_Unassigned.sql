--delete all syncable folder links
--delete from SiteClassLink
where PK_SiteClassLink IN (
select PK_SiteClassLink from SiteClassLink
where SyncState = 0)

--delete all local folder links
--delete from SiteClassLink
--where PK_SiteClassLink IN (
--select PK_SiteClassLink from SiteClassLink
--where SyncState = 1)

-- Use to delete unassigned sample data
delete from sample
--select * from sample
where PK_Sample NOT IN (
select PK_Sample from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)

-- Use to delete unassigned inq data
delete from Inquiry
--select * from sample
where PK_Inquiry NOT IN (
select PK_Inquiry from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Inquiry ON Inquiry.FK_Event = Event.PK_Event  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)

-- Use to delete unassigned Event Data
Delete from Event
Where PK_Event NOT IN(
SELECT DISTINCT PK_Event from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)

--checking event groups
Delete from EventGroup
--Select * from EventGroup
Where PK_EventGroup NOT IN(
SELECT DISTINCT PK_EventGroup from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup)

-- then use this to delete unassined sites
delete from site
--select * from site
where PK_Site NOT IN (
select DISTINCT PK_Site from Site
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)

-- checking Orphan links
delete from SiteClassLink
--select * from SiteClassLink
where PK_SiteClassLink NOT IN (
select DISTINCT PK_SiteClassLink from Site
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)

Delete from Protocol
--Select * from Protocol
Where PK_Protocol NOT IN(
SELECT DISTINCT PK_protocol from Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup)

--delete protocols not in use from typeList
-- Use to delete unassigned sample data
delete from typeList
--select PK_Type from typeList
WHERE List = 'PROTOCOL'
AND PK_Type NOT IN (
select DISTINCT FK_Type_Protocol from Protocol
INNER JOIN typeList ON typeList.PK_Type = Protocol.FK_Type_Protocol
INNER JOIN EventGroup ON EventGroup.FK_Protocol = Protocol.PK_Protocol  
INNER JOIN Event ON Event.FK_EventGroup = EventGroup.PK_EventGroup
INNER JOIN Sample ON Sample.FK_Event = Event.PK_Event  
INNER JOIN Site ON Site.PK_Site = Event.FK_Site 
INNER JOIN SiteClassLink on SiteClassLink.FK_Site = Site.PK_Site
INNER JOIN SiteClass on SiteClass.PK_SiteClass = SiteClassLink.FK_SiteClass)


-- checking Orphan links - Contact
delete from ContactLink
--select * from ContactLink
where PK_ContactLink NOT IN (
select DISTINCT PK_ContactLink from Contact
INNER JOIN ContactLink on ContactLink.FK_Contact = Contact.PK_Contact)

-- getting rid of unused contacts
delete from contact
--select * from contact
where PK_Contact NOT IN (
select DISTINCT PK_Contact from Contact
RIGHT JOIN ContactLink on ContactLink.FK_Contact = Contact.PK_Contact)


--OPTIONAL--
--delete folders (non-root) that ARE SYNCABLE !!
--Delete from SiteClass
Select ClassName from SiteClass
Where PK_SiteClass IN (
  select DISTINCT PK_SiteClass from siteClass
  left join siteClassLink on SiteClassLink.FK_SiteClass = SiteClass.PK_SiteClass
  where SiteClass.SyncState = 0
  and Ck_ParentClass IN (
      select Pk_SiteClass from SiteClass)
)

delete from tombstone





-- Looking at contacts
SELECT ContactLink.FK_Contact, Contact.FamilyName, Contact.GivenName FROM Contact
LEFT JOIN ContactLink ON Contact.PK_Contact = ContactLink.FK_Contact
GROUP BY ContactLink.FK_Contact, Contact.FamilyName, Contact.GivenName
ORDER BY Contact.FamilyName

SELECT ContactLink.FK_Contact, Contact.FamilyName, Contact.GivenName, Count(*) FROM Contact
INNER JOIN ContactLink ON Contact.PK_Contact = ContactLink.FK_Contact
GROUP BY ContactLink.FK_Contact, Contact.FamilyName, Contact.GivenName
ORDER BY Contact.FamilyName


--// Use this to change a contact's GUID
UPDATE ContactLink
SET FK_Contact = X'87aa380af7302e4a9aeca4224b391d72'
WHERE FK_Contact = X'1783d3cd49bc0046a01814bc96247506'

