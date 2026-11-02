-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("Region_ID", "Region_name") VALUES (1, 'North');
INSERT INTO "party" ("Party_ID", "Region_ID", "Party_name") VALUES (1, 1, 'Alpha');
INSERT INTO "party" ("Party_ID", "Region_ID", "Party_name") VALUES (2, 1, 'Alpha');
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