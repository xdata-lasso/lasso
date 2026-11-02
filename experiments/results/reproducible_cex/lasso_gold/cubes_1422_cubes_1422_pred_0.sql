-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1006, 'Robert Wolfe', 'grow', 'fall', 'clearly', 'dinner');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1008, 'Renee Blair', 'not', 'capital', 'win', 'human');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1007, 1006, 'source', 'great', 'blue', 'Brent Abbott');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1009, 1008, 'participant', 'old', 'finally', 'Lisa Hensley');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, took_office, left_office FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('participant', 'old', 'finally')
('source', 'great', 'blue')
*/

-- Prediction Query
SELECT minister, took_office, left_office FROM party ORDER BY left_office, party.party_id NULLS LAST;

/*
Prediction Result:
('source', 'great', 'blue')
('participant', 'old', 'finally')
*/