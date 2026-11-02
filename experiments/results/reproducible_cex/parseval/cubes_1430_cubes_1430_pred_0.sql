-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: party --
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1, -2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (-2147483647, -2147483648, 'fqyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (3, 1, 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4');

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (4, 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4');

-- Inserting into table: member --
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1, '1', 'u', '4nrq');

-- Inserting into table: party_events --
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1, 1, 1, 'lhs_5a3207');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483647, 1, 1, 'lhs_19964c');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (2, 1, 1, 'lhs_5a3207');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (3, 1, 1, 'lhs_19964c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, n AS count___ FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT event_id, event_name, party_id, member_in_charge_id, party_id_other, minister, took_office, left_office, party_name, party_id AS region_id FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.party_id AS party_id_other, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM party_events AS LHS INNER JOIN party AS RHS ON (LHS.party_id = RHS.region_id))) GROUP BY party_name, region_id) ORDER BY party_name, count___ NULLS LAST;

/*
Gold Result:
('vy9uxj4', 4)
*/

-- Prediction Query
SELECT T2.party_name, COUNT(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id;

/*
Prediction Result:
('bnp', 4)
*/