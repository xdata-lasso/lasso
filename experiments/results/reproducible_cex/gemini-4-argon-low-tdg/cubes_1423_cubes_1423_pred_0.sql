-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests ORDER BY party_name, region_name NULLS LAST, primary/secondary sort order, ASC vs DESC, and NULL handling.
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'Zeta_Reg', '2020', 'L1', 'F1', 'C1');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (2, 'Alpha_Reg', '2020', 'L2', 'F2', 'C2');
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (3, NULL, '2020', 'L3', 'F3', 'C3');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (101, 1, 'M1', '2020', '2021', 'Party_B');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (102, 1, 'M2', '2020', '2021', 'Party_A');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (103, 2, 'M3', '2020', '2021', 'Party_A');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (104, 3, 'M4', '2020', '2021', 'Party_A');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (105, 2, 'M5', '2020', '2021', NULL);
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (106, 3, 'M6', '2020', '2021', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_name AS region_name, LHS.date AS date, LHS.label AS label, LHS.format AS format, LHS.catalogue AS catalogue, RHS.party_id AS party_id, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM region AS LHS INNER JOIN party AS RHS ON (LHS.region_id = RHS.region_id)) ORDER BY party_name, region_name NULLS LAST;

/*
Gold Result:
(None, 'Alpha_Reg')
(None, None)
('Party_A', 'Alpha_Reg')
('Party_A', 'Zeta_Reg')
('Party_A', None)
('Party_B', 'Zeta_Reg')
*/

-- Prediction Query
SELECT T1.party_name, T2.region_name FROM party AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id;

/*
Prediction Result:
('Party_B', 'Zeta_Reg')
('Party_A', 'Zeta_Reg')
('Party_A', 'Alpha_Reg')
('Party_A', None)
(None, 'Alpha_Reg')
(None, None)
*/