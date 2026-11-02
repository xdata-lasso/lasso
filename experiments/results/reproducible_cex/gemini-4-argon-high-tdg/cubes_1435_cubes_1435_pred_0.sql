-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 1, 'Smith', '2010', '2015', 'Party_One');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (3, 1, 'Jones', '2015', '2020', 'Party_Three');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (10, 1, 'Taylor', '2020', '2024', 'Party_Ten');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (1, '3', 'Bob', '2020');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (3, '10', 'Alice', '2021');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (10, '1', 'Charlie', '2022');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (14, '1', 'David', '2023');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_id AS party_name FROM (SELECT LHS.member_id AS member_id, LHS.member_name AS member_name, LHS.party_id AS party_id, LHS.in_office AS in_office FROM member AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM party) AS RHS ON (LHS.member_id = RHS.n)) ORDER BY party_name;

/*
Gold Result:
('10',)
*/

-- Prediction Query
SELECT T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id ORDER BY COUNT(*) DESC, T2.party_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Party_One',)
*/