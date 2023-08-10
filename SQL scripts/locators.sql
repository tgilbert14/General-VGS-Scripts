-- Look for empty locators - get rid these if blank in database
Select * from locator
inner join site on site.PK_Site = Locator.FK_Site
where DDLat IS NULL

-- Look at max/mins
Select DDLat, SiteID from locator
inner join site on site.PK_Site = Locator.FK_Site
order by DDLat

-- Look at max/mins
Select DDLong, SiteID from locator
inner join site on site.PK_Site = Locator.FK_Site
order by DDLong