-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1012, 'Jacob Clark', 'push', 'reveal', 'stand', 'almost');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1013, 'Timothy Wong', 'rise', 'garden', 'arrive', 'support');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1014, 'Carolyn Daniel', 'onto', 'threat', 'drop', 'four');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1015, 'James Mayo', 'discuss', 'special', 'term', 'institution');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1020, 'Ann Williams', 'activity', 'rest', 'example', 'brother');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1021, 'Mark Conner', 'response', 'value', 'specific', 'finally');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1022, 'Arthur James', 'set', 'not', 'put', 'learn');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1023, 'Kendra Maddox DVM', 'building', 'social', 'grow', 'coach');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1016, 1012, 'long', 'woman', 'forward', 'Thomas Ellis');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1017, 1012, 'attorney', 'him', 'difference', 'David Hoffman');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1018, 1012, 'development', 'him', 'reality', 'Kevin Hurst');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1019, 1012, 'white', 'him', 'money', 'Daniel Bright');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1024, 1020, 'executive', 'woman', 'could', 'Elizabeth Fowler');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1025, 1020, 'about', 'him', 'movement', 'Brittany Farmer');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1026, 1020, 'seven', 'him', 'while', 'Paula Moreno');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1027, 1020, 'type', 'him', 'born', 'Fred Smith');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister FROM (SELECT * FROM (SELECT * FROM party ORDER BY took_office DESC, party.party_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('long',)
*/

-- Prediction Query
SELECT minister FROM party ORDER BY left_office DESC, party.party_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('seven',)
*/