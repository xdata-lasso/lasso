-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_name, date, label, format, catalogue) VALUES (1, 'default2', 'default1', NULL, 'default1', NULL), (0, NULL, NULL, 'default2', NULL, 'default2'), (2, 'default1', 'default2', NULL, 'default2', NULL);
INSERT INTO party (party_id, region_id, minister, took_office, left_office, party_name) VALUES (1, 1, NULL, 'default1', 'default2', 'default2'), (0, 2, 'default1', NULL, 'default1', 'default1'), (2, 2, NULL, NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_party_name_ FROM (SELECT COUNT(*) AS n FROM party) ORDER BY count_distinct_party_name_;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT party_name) FROM party;

/*
Prediction Result:
(2,)
*/