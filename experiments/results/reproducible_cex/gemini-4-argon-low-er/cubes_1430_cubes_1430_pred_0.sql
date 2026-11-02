-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("Region_ID", "Region_name") VALUES (1, 'North');
INSERT INTO "party" ("Party_ID", "Region_ID", "Party_name") VALUES (2, 1, 'Alpha');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name") VALUES (1, 2, 'John');
INSERT INTO "party_events" ("Event_ID", "Member_in_charge_ID", "Party_ID", "Event_Name") VALUES (1, 1, 2, 'Gala');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, n AS count___ FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT event_id, event_name, party_id, member_in_charge_id, party_id_other, minister, took_office, left_office, party_name, party_id AS region_id FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.party_id AS party_id_other, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM party_events AS LHS INNER JOIN party AS RHS ON (LHS.party_id = RHS.region_id))) GROUP BY party_name, region_id) ORDER BY party_name, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.party_name, COUNT(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id;

/*
Prediction Result:
('Alpha', 1)
*/