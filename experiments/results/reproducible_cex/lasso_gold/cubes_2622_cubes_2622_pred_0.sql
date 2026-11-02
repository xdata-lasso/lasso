-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1043, 'her');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1044, 1043, 'throw');
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1044, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_id, participant_type_code, n AS count___ FROM (SELECT LHS.participant_id AS participant_id, LHS.n AS n, RHS.participant_type_code AS participant_type_code, RHS.participant_details AS participant_details FROM (SELECT participant_id, COUNT(*) AS n FROM participants_in_events GROUP BY participant_id) AS LHS LEFT JOIN participants AS RHS ON (LHS.participant_id = RHS.participant_id)) ORDER BY participant_id, participant_type_code NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, 1)
*/

-- Prediction Query
SELECT T1.Participant_ID, T1.Participant_Type_Code, COUNT(*) FROM Participants AS T1 JOIN Participants_in_Events AS T2 ON T1.Participant_ID = T2.Participant_ID GROUP BY T1.Participant_ID;

/*
Prediction Result:
*/