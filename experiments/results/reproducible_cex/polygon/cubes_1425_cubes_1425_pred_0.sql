-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (7, '8', '8', '8', '8', '8');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (9, 7, '8', '8', '8', '14');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (8, 7, '8', '8', '8', '14');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (10, 8, '8', '8');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (12, 10, 8, '8');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (11, 10, 8, '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_party_name_ FROM (SELECT COUNT(*) AS n FROM party) ORDER BY count_distinct_party_name_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT party_name) FROM party;

/*
Prediction Result:
(1,)
*/