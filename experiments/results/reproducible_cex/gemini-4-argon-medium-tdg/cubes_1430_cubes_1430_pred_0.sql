-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (2, 'South', '2020-01-02', 'L2', 'F2', 'C2');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (3, 'East', '2020-01-03', 'L3', 'F3', 'C3');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 2, 'Alice', '2020', '2021', 'Alpha');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (2, 1, 'Bob', '2021', '2022', 'Beta');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (3, 1, 'Charlie', '2022', '2023', 'Alpha');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (4, 3, 'David', '2019', '2020', 'Gamma');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (1, '1', 'M1', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (2, '2', 'M2', 'No');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (10, 1, 1, 'Gala');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (20, 1, 1, 'Rally');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (30, 2, 2, 'Fundraiser');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (40, 2, 4, 'UnmatchedEvent');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, n AS count___ FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT event_id, event_name, party_id, member_in_charge_id, party_id_other, minister, took_office, left_office, party_name, party_id AS region_id FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.party_id AS party_id_other, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM party_events AS LHS INNER JOIN party AS RHS ON (LHS.party_id = RHS.region_id))) GROUP BY party_name, region_id) ORDER BY party_name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 2)
('Beta', 2)
*/

-- Prediction Query
SELECT T2.party_name, COUNT(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id;

/*
Prediction Result:
('Alpha', 2)
('Beta', 1)
('Gamma', 1)
*/