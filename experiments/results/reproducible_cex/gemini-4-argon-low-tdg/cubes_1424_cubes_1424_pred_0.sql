-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'North', '2000', 'L1', 'F1', 'C1');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (2, 'South', '2005', 'L2', 'F2', 'C2');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (1, 1, 'Alice', '2010', '2025', 'Alpha Party');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (2, NULL, 'Bob', '2020', '2021', 'Beta Party');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (3, 2, 'Charlie', '2015', '2030', 'Gamma Party');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (4, 1, 'David', NULL, '2040', 'Delta Party');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (1, '1', 'Mem1', '2010');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (2, '3', 'Mem2', '2015');
INSERT INTO "party_events" ("Event_ID", "Member_in_charge_ID", "Party_ID", "Event_Name") VALUES (1, 1, 1, 'Event1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister FROM (SELECT * FROM (SELECT * FROM party ORDER BY took_office DESC, party.party_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT minister FROM party ORDER BY left_office DESC, party.party_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('David',)
*/