-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: party --
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (-2147483648, -2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

-- Inserting into table: member --
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1, '-2147483648', 't1__63c1b8', 'mdpos');

INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (2, '-2147483648', 't1__63c1b8', '76nium52');

INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (3, '-2147483648', 't1__63c1b8', 'u');

INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (4, '-2147483648', '5sw', 'qcgsk9');

INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (5, '-2147483648', '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: party_events --
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483648, 1, -2147483648, 'e5u');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483647, 1, -2147483648, '6klfa9');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483646, 1, -2147483648, '00t5c4ecigc');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483645, 2, -2147483648, 'nrqrofqy');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483644, 2, -2147483648, 's5bbp02e');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (2, 1, -2147483648, 'qa1');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (3, 1, -2147483648, 'yytoo');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483643, 1, -2147483648, '9hl7');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483640, 1, -2147483648, 'x14ji7zwau2d');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483639, 1, -2147483648, '3pyu78d');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483638, 1, -2147483648, '0b4');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483637, 1, -2147483648, '2rk');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483636, 1, -2147483648, 'x58pz');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483635, 1, -2147483648, 'f8jegd21vy9u');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (-2147483634, 1, -2147483648, 'j4hwbdvlph');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (5, 4, -2147483648, 'sr');

INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (4, 4, -2147483648, 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT member_name FROM (SELECT event_id, event_name, party_id, member_in_charge_id, member_name, event_id AS n FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.member_name AS member_name FROM party_events AS LHS INNER JOIN (SELECT member_id, member_name, COUNT(*) AS n FROM member GROUP BY member_id, member_name) AS RHS ON (LHS.event_id = RHS.n AND LHS.member_in_charge_id = RHS.member_id))) ORDER BY member_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.member_name FROM member AS T1 JOIN party_events AS T2 ON T1.member_id = T2.member_in_charge_id GROUP BY T2.member_in_charge_id ORDER BY COUNT(*) DESC, T1.member_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__63c1b8',)
*/