-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_name, date, label, format, catalogue) VALUES (1, 'default1', 'default2', 'default2', 'default1', 'default1'), (0, NULL, 'default1', NULL, 'default2', 'default1');
INSERT INTO party (party_id, region_id, minister, took_office, left_office, party_name) VALUES (0, 0, 'default1', 'default2', 'default2', NULL), (1, 1, 'default1', 'default2', 'default1', NULL), (2, NULL, NULL, 'default1', 'default2', NULL), (3, NULL, NULL, 'default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_name AS region_name, LHS.date AS date, LHS.label AS label, LHS.format AS format, LHS.catalogue AS catalogue, RHS.party_id AS party_id, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM region AS LHS INNER JOIN party AS RHS ON (LHS.region_id = RHS.region_id)) ORDER BY party_name, region_name NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, None)
*/

-- Prediction Query
SELECT T1.party_name, T2.region_name FROM party AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id;

/*
Prediction Result:
(None, None)
(None, 'default1')
*/