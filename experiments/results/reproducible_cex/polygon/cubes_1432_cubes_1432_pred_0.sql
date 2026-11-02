-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (15, '1', '1', '1', '1', '1');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (14, '1', '1', '1', '1', '1');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (17, 14, '1', '1', '1', '1');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (29, NULL, '1', '1', '1', '1');
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (19, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "party_id", "member_name", "in_office") VALUES (20, 17, NULL, '34');
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (18, 19, NULL, NULL);
INSERT INTO "party_events" ("event_id", "member_in_charge_id", "party_id", "event_name") VALUES (1, 20, 29, '28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT member_name FROM (SELECT event_id, event_name, party_id, member_in_charge_id, member_name, event_id AS n FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.member_name AS member_name FROM party_events AS LHS INNER JOIN (SELECT member_id, member_name, COUNT(*) AS n FROM member GROUP BY member_id, member_name) AS RHS ON (LHS.event_id = RHS.n AND LHS.member_in_charge_id = RHS.member_id))) ORDER BY member_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.member_name FROM member AS T1 JOIN party_events AS T2 ON T1.member_id = T2.member_in_charge_id GROUP BY T2.member_in_charge_id ORDER BY COUNT(*) DESC, T1.member_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/