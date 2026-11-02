-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL Service_ID in Events (since SQLite NULL = NULL is Unknown/False in the correlated subquery:
-- LHS.service_id = RHS.service_id).
-- Also tests sharing the same Service_ID with an event attended by Kenyatta Kuhn.
INSERT INTO "Services" ("Service_ID", "Service_Type_Code") VALUES (100, 'Svc100');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code") VALUES (200, 'Svc200');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (10, 'PT1', 'Kenyatta Kuhn');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (20, 'PT2', 'Other Person');
-- Event 1: Has NULL Service_ID and is attended by Kenyatta Kuhn.
-- In Gold Query, LHS.service_id = RHS.service_id evaluates to NULL, so NOT EXISTS is TRUE! (Included in Gold)
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (1, NULL, 'Null Service Event With Kenyatta');
-- Event 2: Has Service_ID 100 and is attended by Kenyatta Kuhn. (Excluded)
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (2, 100, 'Service 100 With Kenyatta');
-- Event 3: Shares Service_ID 100 with Event 2, but attended by Other Person.
-- Tests mutants that correlate only on LHS.service_id = RHS.service_id instead of event_id. (Included)
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (3, 100, 'Service 100 Without Kenyatta');
-- Event 4: Has NULL Service_ID and no participants. (Included)
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (4, NULL, 'Null Service Empty');
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (1, 10);
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (2, 10);
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (3, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "event_id" FROM (SELECT * FROM "events" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."participant_id" AS "participant_id", "LHS"."participant_type_code" AS "participant_type_code", "LHS"."participant_details" AS "participant_details", "LHS"."event_id" AS "event_id", "LHS"."service_id" AS "service_id", "LHS"."event_details" AS "event_details" FROM (SELECT "LHS"."participant_id" AS "participant_id", "LHS"."participant_type_code" AS "participant_type_code", "LHS"."participant_details" AS "participant_details", "RHS"."event_id" AS "event_id", "RHS"."service_id" AS "service_id", "RHS"."event_details" AS "event_details" FROM "participants" AS "LHS" CROSS JOIN "events" AS "RHS") AS "LHS" INNER JOIN "participants_in_events" AS "RHS" ON ("LHS"."participant_id" = "RHS"."participant_id" AND "LHS"."event_id" = "RHS"."event_id")) WHERE ("participant_details" = 'Kenyatta Kuhn')) AS RHS WHERE (LHS.event_id = RHS.event_id AND LHS.service_id = RHS.service_id))) ORDER BY event_id, "event_id" NULLS LAST;

/*
Gold Result:
(1,)
(3,)
(4,)
*/

-- Prediction Query
SELECT event_id FROM EVENTS EXCEPT SELECT T1.event_id FROM Participants_in_Events AS T1 JOIN Participants AS T2 ON T1.Participant_ID = T2.Participant_ID WHERE Participant_Details = 'Kenyatta Kuhn';

/*
Prediction Result:
(3,)
(4,)
*/