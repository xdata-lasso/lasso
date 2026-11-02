-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(DISTINCT Party_name) vs COUNT(Party_name) vs COUNT(Region_ID)
-- 2. Unnecessary INNER JOINs with region, member, or party_events (missing FKs or unreferenced rows)
-- 3. GROUP BY Party_name or Region_ID instead of overall aggregate
-- 4. Querying the wrong table (region has 1 row, member has 1 row, party_events has 2 rows, party has 4 rows)
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (1, 1, 'Alice', '2020', '2021', 'Alpha');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (2, 1, 'Bob', '2021', '2022', 'Alpha');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (3, NULL, 'Charlie', '2022', '2023', NULL);
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (4, 1, NULL, NULL, NULL, 'Beta');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (1, '1', 'M1', 'Yes');
INSERT INTO "party_events" ("Event_ID", "Member_in_charge_ID", "Party_ID", "Event_Name") VALUES (1, 1, 1, 'E1');
INSERT INTO "party_events" ("Event_ID", "Member_in_charge_ID", "Party_ID", "Event_Name") VALUES (2, 1, 1, 'E2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_party_name_ FROM (SELECT COUNT(*) AS n FROM party) ORDER BY count_distinct_party_name_;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT party_name) FROM party;

/*
Prediction Result:
(2,)
*/