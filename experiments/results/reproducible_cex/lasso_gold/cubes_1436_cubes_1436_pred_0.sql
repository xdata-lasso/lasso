-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1028, 'Aaron Bowen', 'serve', 'everyone', 'month', 'sound');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1030, 'Christina Brooks', 'color', 'notice', 'start', 'win');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1029, 1028, 'him', 'movement', 'a', 'Mario Skinner');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1031, 1030, 'could', 'why', 'while', 'Katherine Rodriguez');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "minister" FROM "party" WHERE ("party_name" <> 'Progress Party') ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('could',)
('him',)
*/

-- Prediction Query
SELECT minister FROM party WHERE party_name <> 'Progress Party';

/*
Prediction Result:
('him',)
('could',)
*/