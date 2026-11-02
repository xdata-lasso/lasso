-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (16, NULL, '15', '15', '15', '15');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (15, NULL, '28', '29', '30', '31');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (19, NULL, '15', '15');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (18, 15, '24', '25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_id AS party_name FROM (SELECT LHS.member_id AS member_id, LHS.member_name AS member_name, LHS.party_id AS party_id, LHS.in_office AS in_office FROM member AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM party) AS RHS ON (LHS.member_id = RHS.n)) ORDER BY party_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id ORDER BY COUNT(*) DESC, T2.party_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('31',)
*/