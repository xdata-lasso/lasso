-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests DISTINCT (duplicate Region_name), ORDER BY (inserted out of alphabetical order),
-- and unnecessary INNER JOINs (Region 1 and 2 have no related records in 'party').
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'Zulu', '2020-01-01', 'LabelA', 'CD', 'Cat1');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (2, 'Alpha', '2021-01-01', 'LabelB', 'LP', 'Cat2');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (3, 'Alpha', '2022-01-01', 'LabelC', 'Cassette', 'Cat3');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (4, 'Bravo', '2019-01-01', 'LabelD', 'Digital', 'Cat4');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (10, 3, 'Smith', '2020', '2021', 'Green');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (11, 3, 'Jones', '2021', '2022', 'Blue');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (12, 4, 'Brown', '2019', '2023', 'Red');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM region ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Bravo',)
('Zulu',)
*/

-- Prediction Query
SELECT DISTINCT region_name FROM region ORDER BY Label, region_name NULLS LAST;

/*
Prediction Result:
('Zulu',)
('Alpha',)
('Bravo',)
*/