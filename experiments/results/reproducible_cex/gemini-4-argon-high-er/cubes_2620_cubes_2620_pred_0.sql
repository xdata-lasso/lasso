-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (1, 'A', 'Kenyatta Kuhn');
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (1, NULL, 'Event 1');
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "event_id" FROM (SELECT * FROM "events" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."participant_id" AS "participant_id", "LHS"."participant_type_code" AS "participant_type_code", "LHS"."participant_details" AS "participant_details", "LHS"."event_id" AS "event_id", "LHS"."service_id" AS "service_id", "LHS"."event_details" AS "event_details" FROM (SELECT "LHS"."participant_id" AS "participant_id", "LHS"."participant_type_code" AS "participant_type_code", "LHS"."participant_details" AS "participant_details", "RHS"."event_id" AS "event_id", "RHS"."service_id" AS "service_id", "RHS"."event_details" AS "event_details" FROM "participants" AS "LHS" CROSS JOIN "events" AS "RHS") AS "LHS" INNER JOIN "participants_in_events" AS "RHS" ON ("LHS"."participant_id" = "RHS"."participant_id" AND "LHS"."event_id" = "RHS"."event_id")) WHERE ("participant_details" = 'Kenyatta Kuhn')) AS RHS WHERE (LHS.event_id = RHS.event_id AND LHS.service_id = RHS.service_id))) ORDER BY event_id, "event_id" NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT event_id FROM EVENTS EXCEPT SELECT T1.event_id FROM Participants_in_Events AS T1 JOIN Participants AS T2 ON T1.Participant_ID = T2.Participant_ID WHERE Participant_Details = 'Kenyatta Kuhn';

/*
Prediction Result:
*/