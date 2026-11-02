-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2002-01-01', 'L2', 'F3', 'C2');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (2, 'East', '2003-01-01', 'L3', 'F1', 'C3');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (3, 'West', '2001-01-01', 'L1', 'F2', 'C1');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (4, 'East', '2004-01-01', 'L4', 'F4', 'C4');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (10, 1, 'Alice Smith', '2010', '2014', 'Northern Alliance');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (20, 1, 'Bob Jones', '2014', '2018', 'Civic Union');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (30, 2, 'Carol White', '2012', '2016', 'Eastern Front');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (100, '10', 'David Brown', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (200, '20', 'Eve Davis', 'No');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (1000, 100, 10, 'Annual Summit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM region ORDER BY region_name;

/*
Gold Result:
('East',)
('North',)
('West',)
*/

-- Prediction Query
SELECT DISTINCT region_name FROM region ORDER BY Label, region_name NULLS LAST;

/*
Prediction Result:
('West',)
('North',)
('East',)
*/