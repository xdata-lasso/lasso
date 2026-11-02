-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Services" ("Service_ID", "Service_Type_Code") VALUES (1, 'S1');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (1, 'P1', 'D1');
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (2, 1, 'E2');
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT event_id_other AS event_id FROM (SELECT LHS.event_id AS event_id, LHS.participant_id AS participant_id, RHS.event_id AS event_id_other FROM participants_in_events AS LHS INNER JOIN (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id) AS RHS ON (LHS.event_id = RHS.n)) ORDER BY event_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/