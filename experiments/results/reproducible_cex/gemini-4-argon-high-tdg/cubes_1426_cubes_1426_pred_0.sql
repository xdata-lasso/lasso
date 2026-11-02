-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (10, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (20, 'South', '2020-01-02', 'L2', 'F2', 'C2');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (30, 'East', '2020-01-03', 'L3', 'F3', 'C3');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (40, 'West', '2020-01-04', 'L4', 'F4', 'C4');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 20, 'Smith', '2018', '2022', 'Zeta Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (2, 30, 'Jones', '2019', '2023', 'Alpha Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (3, 10, 'Brown', '2020', '2024', 'Beta Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (4, 40, 'Taylor', '2017', '2021', 'Gamma Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (5, 10, 'Wilson', '2016', '2020', 'Delta Party');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (1, '1', 'Alice', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (2, '2', 'Bob', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (3, '3', 'Charlie', 'No');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (4, '4', 'David', 'Yes');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (101, 1, 1, 'Zeta Gala 1');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (102, 1, 1, 'Zeta Gala 2');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (103, 1, 1, 'Zeta Gala 3');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (104, 1, 1, 'Zeta Gala 4');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (201, 2, 2, 'Alpha Summit 1');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (202, 2, 2, 'Alpha Summit 2');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (203, 2, 2, 'Alpha Summit 3');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (301, 3, 3, 'Beta Forum 1');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (302, 3, 3, 'Beta Forum 2');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (401, 4, 4, 'Gamma Meet 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT LHS.party_id AS party_id, LHS.minister AS minister, LHS.took_office AS took_office, LHS.left_office AS left_office, LHS.region_id AS region_id, LHS.party_name AS party_name, RHS.event_id AS event_id, RHS.event_name AS event_name, RHS.member_in_charge_id AS member_in_charge_id FROM party AS LHS LEFT JOIN party_events AS RHS ON (LHS.party_id = RHS.party_id)) GROUP BY party_name, region_id) WHERE (n >= 2) ORDER BY party_name;

/*
Gold Result:
('Alpha Party',)
('Beta Party',)
('Zeta Party',)
*/

-- Prediction Query
SELECT T2.party_name FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zeta Party',)
('Alpha Party',)
('Beta Party',)
*/