-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (1, 1, 'Alice', '2020', '2021', '2');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (2, 1, 'Bob', '2021', '2022', '3');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (3, 1, 'Charlie', '2022', '2023', '99');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (10, '2', 'MemA', 'Yes');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (20, '2', 'MemB', 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party_name FROM (SELECT LHS.party_name AS party_name, LHS.maxn AS maxn, RHS.member_id AS member_id, RHS.member_name AS member_name, RHS.in_office AS in_office FROM (SELECT party_name, MAX(n) AS maxn FROM (SELECT minister, party_name, COUNT(*) AS n FROM party GROUP BY minister, party_name) GROUP BY party_name) AS LHS INNER JOIN member AS RHS ON (LHS.party_name = RHS.party_id)) ORDER BY party_name;

/*
Gold Result:
('2',)
*/

-- Prediction Query
SELECT T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id ORDER BY COUNT(*) DESC, T2.party_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('3',)
*/