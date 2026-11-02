-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'Lbl_1', 'Fmt_1', 'Cat_1');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (2, 'South', '2020-01-02', 'Lbl_2', 'Fmt_2', 'Cat_2');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (10, 'East_Unmatched', '2020-01-03', 'Lbl_3', 'Fmt_3', 'Cat_3');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (10, 1, 'Minister_Z', '2020-02-01', '2021-02-01', 'Zeta');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (20, 2, 'Minister_A', '2021-03-01', '2022-03-01', 'Alpha');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (30, NULL, 'Minister_B', '2022-04-01', '2023-04-01', 'Beta_Orphan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_name AS region_name, LHS.date AS date, LHS.label AS label, LHS.format AS format, LHS.catalogue AS catalogue, RHS.party_id AS party_id, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM region AS LHS INNER JOIN party AS RHS ON (LHS.region_id = RHS.region_id)) ORDER BY party_name, region_name NULLS LAST;

/*
Gold Result:
('Alpha', 'South')
('Zeta', 'North')
*/

-- Prediction Query
SELECT T1.party_name, T2.region_name FROM party AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id;

/*
Prediction Result:
('Zeta', 'North')
('Alpha', 'South')
*/