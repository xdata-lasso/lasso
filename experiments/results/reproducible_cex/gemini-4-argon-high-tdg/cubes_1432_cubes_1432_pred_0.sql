-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 1, 'Min A', '2020', '2021', 'Alpha');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (10, '1', 'Alice', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (20, '1', 'Bob', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (30, '1', 'Charlie', 'No');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (0, 10, 1, 'Gala Zero');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (1, 20, 1, 'Gala One');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (2, 30, 1, 'Gala Two');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT member_name FROM (SELECT event_id, event_name, party_id, member_in_charge_id, member_name, event_id AS n FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.member_name AS member_name FROM party_events AS LHS INNER JOIN (SELECT member_id, member_name, COUNT(*) AS n FROM member GROUP BY member_id, member_name) AS RHS ON (LHS.event_id = RHS.n AND LHS.member_in_charge_id = RHS.member_id))) ORDER BY member_name;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT T1.member_name FROM member AS T1 JOIN party_events AS T2 ON T1.member_id = T2.member_in_charge_id GROUP BY T2.member_in_charge_id ORDER BY COUNT(*) DESC, T1.member_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/