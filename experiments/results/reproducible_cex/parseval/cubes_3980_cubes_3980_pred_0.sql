-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: party --
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1, -2147483648, 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (-2147483647, -2147483648, '72k', 'ex1', 'ji7zwau2', '1');

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (-2147483648, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: member --
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1, '1', 'dwyrq13pyu78', '9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party_name FROM (SELECT LHS.party_name AS party_name, LHS.maxn AS maxn, RHS.member_id AS member_id, RHS.member_name AS member_name, RHS.in_office AS in_office FROM (SELECT party_name, MAX(n) AS maxn FROM (SELECT minister, party_name, COUNT(*) AS n FROM party GROUP BY minister, party_name) GROUP BY party_name) AS LHS INNER JOIN member AS RHS ON (LHS.party_name = RHS.party_id)) ORDER BY party_name;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id ORDER BY COUNT(*) DESC, T2.party_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('ytoo3o9',)
*/