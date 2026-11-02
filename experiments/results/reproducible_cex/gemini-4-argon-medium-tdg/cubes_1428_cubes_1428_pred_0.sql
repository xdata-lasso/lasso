-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'Zeta', '2022-03-01', 'Alpha', 'CD', 'Cat-3');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (2, 'Alpha', '2022-02-01', 'Zeta', 'Vinyl', 'Cat-1');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (3, 'Beta', '2022-01-01', 'Beta', 'Digital', 'Cat-2');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (4, 'Alpha', '2022-04-01', 'Gamma', 'Cassette', 'Cat-4');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (10, 1, 'John Doe', '2020', '2021', 'Party A');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (20, 1, 'Jane Smith', '2021', '2022', 'Party B');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (30, 3, 'Bob Brown', '2019', '2020', 'Party C');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (100, '10', 'Alice', 'Yes');
INSERT INTO "party_events" ("Event_ID", "Member_in_charge_ID", "Party_ID", "Event_Name") VALUES (1000, 100, 10, 'Annual Gala');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM region ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT DISTINCT region_name FROM region ORDER BY Label, region_name NULLS LAST;

/*
Prediction Result:
('Zeta',)
('Beta',)
('Alpha',)
*/