-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1004, 'Kevin Pacheco', 'according', 'song', 'sure', 'collection');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1007, 'Valerie Gray', 'old', 'finally', 'themselves', 'production');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1004, 1004, 'save', 'knowledge', 'grow', 'Daniel Gallagher');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1007, 1007, 'present', 'value', 'training', 'Corey Jones');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1005, 1004, 'James Howard', 'guy');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1008, 1007, 'Patricia Galloway', 'top');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1006, 1005, 1004, 'Renee Blair');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1009, NULL, 1007, 'Brian Ramirez');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, n AS count___ FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT event_id, event_name, party_id, member_in_charge_id, party_id_other, minister, took_office, left_office, party_name, party_id AS region_id FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.party_id AS party_id_other, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM party_events AS LHS INNER JOIN party AS RHS ON (LHS.party_id = RHS.region_id))) GROUP BY party_name, region_id) ORDER BY party_name, count___ NULLS LAST;

/*
Gold Result:
('Corey Jones', 1)
('Daniel Gallagher', 1)
*/

-- Prediction Query
SELECT T2.party_name, COUNT(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id;

/*
Prediction Result:
('Daniel Gallagher', 1)
('Corey Jones', 1)
*/