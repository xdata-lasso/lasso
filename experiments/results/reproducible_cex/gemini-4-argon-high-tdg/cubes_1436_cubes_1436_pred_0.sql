-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (1, 1, 'Zelda', '2018', '2020', 'Alliance Party');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (2, 1, 'Arthur', '2019', '2021', 'Progress Party');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (3, 1, 'charlie', '2020', '2022', 'Workers Party');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (4, 1, 'Bob', '2021', '2023', 'Civic Party');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "minister" FROM "party" WHERE ("party_name" <> 'Progress Party') ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('Bob',)
('Zelda',)
('charlie',)
*/

-- Prediction Query
SELECT minister FROM party WHERE party_name <> 'Progress Party';

/*
Prediction Result:
('Zelda',)
('charlie',)
('Bob',)
*/