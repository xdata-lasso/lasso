-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1001, 'purpose', 'brother');
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1002, 'ago');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1, 1002, 'site');
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id AS count___ FROM (SELECT LHS.event_id AS event_id, LHS.service_id AS service_id, LHS.event_details AS event_details, RHS.participant_id AS participant_id FROM events AS LHS INNER JOIN (SELECT participant_id, COUNT(DISTINCT event_id) AS n_distinct FROM participants_in_events GROUP BY participant_id) AS RHS ON (LHS.event_id = RHS.n_distinct)) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM EVENTS WHERE NOT event_id IN (SELECT event_id FROM Participants_in_Events);

/*
Prediction Result:
(0,)
*/