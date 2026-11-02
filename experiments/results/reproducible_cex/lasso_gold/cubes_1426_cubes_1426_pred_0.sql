-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1018, 'Dylan Miller', 'determine', 'science', 'raise', 'prove');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1019, 'Brian Ramirez', 'religious', 'write', 'away', 'Congress');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1020, 'Holly Wood', 'example', 'result', 'politics', 'none');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1030, 'Holly Wood', 'example', 'result', 'politics', 'none');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1035, 'Zachary Taylor', 'image', 'management', 'on', 'activity');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1036, 'Peter Callahan Jr.', 'I', 'newspaper', 'traditional', 'response');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1037, 'Michael Carlson', 'pick', 'enter', 'yes', 'set');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1047, 'Michael Carlson', 'pick', 'enter', 'yes', 'set');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1021, 1018, 'shoulder', 'maintain', 'wish', 'Melinda Cameron');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1022, 1018, 'election', 'hundred', 'push', 'Melinda Cameron');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1023, 1018, 'common', 'expect', 'rise', 'Melinda Cameron');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1032, 1018, 'common', 'expect', 'rise', 'Melinda Cameron');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1038, NULL, 'building', 'not', 'put', 'Christopher Smith');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1039, NULL, 'rest', 'social', 'grow', 'Christopher Smith');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1040, NULL, 'value', 'specific', 'brother', 'Christopher Smith');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1049, NULL, 'value', 'specific', 'brother', 'Christopher Smith');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1024, 1021, 'Crystal Johnson', 'reality');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1025, 1021, 'Derek Clark', 'money');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1026, 1021, 'Sherri Edwards', 'individual');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1033, NULL, 'Sherri Edwards', 'individual');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1041, 1038, 'Michelle Stanton', 'decide');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1042, 1038, 'Katie Rodriguez', 'claim');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1043, 1038, 'Sarah Romero', 'hour');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (1050, NULL, 'Sarah Romero', 'hour');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1027, 1024, 1021, 'Maria Thomas');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1028, 1024, 1021, 'Patrick Ryan');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1029, 1024, 1021, 'Jessica Silva');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1034, 1024, NULL, 'Jessica Silva');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1044, 1041, 1038, 'Kimberly Osborne');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1045, 1041, 1038, 'April Nguyen');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1046, 1041, 1038, 'Timothy Koch');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1051, 1041, NULL, 'Timothy Koch');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT LHS.party_id AS party_id, LHS.minister AS minister, LHS.took_office AS took_office, LHS.left_office AS left_office, LHS.region_id AS region_id, LHS.party_name AS party_name, RHS.event_id AS event_id, RHS.event_name AS event_name, RHS.member_in_charge_id AS member_in_charge_id FROM party AS LHS LEFT JOIN party_events AS RHS ON (LHS.party_id = RHS.party_id)) GROUP BY party_name, region_id) WHERE (n >= 2) ORDER BY party_name;

/*
Gold Result:
('Christopher Smith',)
('Melinda Cameron',)
*/

-- Prediction Query
SELECT T2.party_name FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Melinda Cameron',)
('Christopher Smith',)
*/