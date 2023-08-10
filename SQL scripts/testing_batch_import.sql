INSERT INTO Site
           (PK_Site
           ,FK_Species_Site
           ,FK_Species_SiteStatus
           ,FK_Species_ElevUnits
           ,SiteID
           ,Notes
           ,Slope
           ,Aspect
           ,Elevation
           ,DateEstablished
           ,SyncKey
           ,SyncState)
     VALUES
           (X'14e75916acd2432ea3c1f8b35dd9a213',
            'SITE_KEY',
            'SST_ACTIVE',
            'UNIT_FEET',
            'Testerrr',
            'these are site notes',
            54,
            55,
            2344,
            NULL,
            33,
            1)

INSERT INTO Protocol
  (PK_Protocol
    ,FK_Type_Protocol
    ,Bailiwick
    ,ProtocolName
    ,Date
    ,DateEnd
    ,Notes
    ,SyncKey
    ,SyncState)
  VALUES
  (X'a4dc8372e9c4492ca34324d3c5f859bc',x'e201367f8b435949a752b17815fd38ad',NULL,'R6 Rogue River - Tally','2011-08-29 00:00:00',NULL,'specific event notes',33,1)

INSERT INTO EventGroup
           (PK_EventGroup
           ,FK_Type_EventGroup
           ,FK_Protocol
           ,Attributes
           ,GroupName
           ,DisplayOrder
           ,DefaultFormID
           ,SyncKey
           ,SyncState)
     VALUES
           (X'97cd3ec5812741f68e2585fac2a8dddd',X'084445a424fa9f4b8dd7e910b6b95ffc',x'a4dc8372e9c4492ca34324d3c5f859bc',
'<FormAttributes>
  <Level1>
    <ID>NumberOfTransects</ID>
    <Label>Number of Transects</Label>
    <Value>1</Value>
    <Qualifier />
    <Visible>1</Visible>
  </Level1>
  <Level1>
    <ID>TransectLength</ID>
    <Label>Transect Length (must be in same units as sample measurements)</Label>
    <Value>0</Value>
    <Qualifier>Meters</Qualifier>
    <Visible>1</Visible>
  </Level1>
  <Level1>
    <ID>SamplesLayout</ID>
    <Label>Samples</Label>
    <LayoutType>Header</LayoutType>
    <Value />
    <Qualifier />
    <Visible>1</Visible>
    <Level2>
      <ID>SamplesPerTransect</ID>
      <Label>Samples Per Transect</Label>
      <Parent>SamplesLayout</Parent>
      <Value>1</Value>
      <Qualifier />
      <Visible>1</Visible>
      <LayoutType />
    </Level2>
  </Level1>
</FormAttributes>','Tally - Freq/GC/DWR/Fetch',1,X'07569942d4ceda4590c6b725db6944ad',33,1)

INSERT INTO Event
         (PK_Event
         ,FK_Type_Event
         ,FK_Site
         ,FK_SiteClass
         ,FK_EventGroup
         ,EventName
         ,Attributes
         ,PageNumber
         ,EntryOrder
         ,DefaultEventID
         ,SyncKey
         ,SyncState)
   VALUES
         (X'64c5b1d169014c5da84b411bba80d4aa',X'9823fa03fbda234c831de8a3d2e41b86',x'14e75916acd2432ea3c1f8b35dd9a213',NULL,X'97CD3EC5812741F68E2585FAC2A8DDDD','Frequency (by tally)',
'<EventAttributes>
  <Level1>
    <ID>ForceNoneSelection</ID>
    <Label>Enforce accounting for unsampled points</Label>
    <Value>True</Value>
    <Qualifier />
    <Visible>1</Visible>
    <LayoutType />
  </Level1>
  <Level1>
    <ID>PointsPerSample</ID>
    <Label>Points Per Quadrat</Label>
    <Value>4</Value>
    <Qualifier />
    <Visible>1</Visible>
  </Level1>
  <Level1>
    <ID>IncludeSpecies</ID>
    <Label>Ground Cover - Record basal hits by species</Label>
    <Value>False</Value>
    <Qualifier />
    <Visible>1</Visible>
  </Level1>
  <Level1>
    <ID>GCCategoryList</ID>
    <Label>Ground Cover - Category List</Label>
    <Value>6223bb59-9986-4d1e-9a49-0df13cfb2552</Value>
    <Qualifier />
    <Visible>1</Visible>
    <LayoutType />
  </Level1>
</EventAttributes>',1,2,X'5cdb4d4b8f90ee43a4c3199133d7b983',33,1)

