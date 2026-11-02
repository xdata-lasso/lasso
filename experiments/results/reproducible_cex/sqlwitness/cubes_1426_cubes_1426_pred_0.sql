-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, region_id, minister, took_office, left_office, party_name) VALUES (0, NULL, 'default2', NULL, NULL, 'default1'), (3, NULL, 'default2', 'default2', 'default2', NULL);
INSERT INTO member (member_id, party_id, member_name, in_office) VALUES (0, 3, NULL, NULL), (2, 3, 'default1', 'default2'), (1, 0, 'default1', 'default2');
INSERT INTO party_events (event_id, member_in_charge_id, party_id, event_name) VALUES (3, NULL, 3, 'default2'), (2, 2, 0, 'default2'), (0, NULL, 0, NULL), (1, 0, 3, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT LHS.party_id AS party_id, LHS.minister AS minister, LHS.took_office AS took_office, LHS.left_office AS left_office, LHS.region_id AS region_id, LHS.party_name AS party_name, RHS.event_id AS event_id, RHS.event_name AS event_name, RHS.member_in_charge_id AS member_in_charge_id FROM party AS LHS LEFT JOIN party_events AS RHS ON (LHS.party_id = RHS.party_id)) GROUP BY party_name, region_id) WHERE (n >= 2) ORDER BY party_name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T2.party_name FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('default1',)
(None,)
*/