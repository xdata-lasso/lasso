-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests boundary condition where Member_ID = 1, Event_ID = 1, and COUNT(*) = 1, vs another member who actually owns Event_ID = 1.
-- Catches mutants that confuse LHS.member_in_charge_id = RHS.member_id with LHS.event_id = RHS.member_id or RHS.member_id = RHS.n.
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'South', '2021-01-01', 'L2', 'F2', 'C2');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 1, 'Min B', '2021', '2025', 'Beta Party');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (1, '1', 'Charlie', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (50, '1', 'David', 'Yes');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (1, 50, 1, 'Opening');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (50, 1, 1, 'Closing');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT member_name FROM (SELECT event_id, event_name, party_id, member_in_charge_id, member_name, event_id AS n FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.member_name AS member_name FROM party_events AS LHS INNER JOIN (SELECT member_id, member_name, COUNT(*) AS n FROM member GROUP BY member_id, member_name) AS RHS ON (LHS.event_id = RHS.n AND LHS.member_in_charge_id = RHS.member_id))) ORDER BY member_name;

/*
Gold Result:
('David',)
*/

-- Prediction Query
SELECT T1.member_name FROM member AS T1 JOIN party_events AS T2 ON T1.member_id = T2.member_in_charge_id GROUP BY T2.member_in_charge_id ORDER BY COUNT(*) DESC, T1.member_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Charlie',)
*/