-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1038, 'fall', 'Kenyatta Kuhn');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1044, 'collection', 'Kenyatta Kuhn');
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1039, 'table');
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1045, 'save');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1040, 1039, 'true');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1046, 1045, 'knowledge');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1043, NULL, NULL);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1040, 1038);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1043, 1038);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1046, 1044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "event_id" FROM (SELECT * FROM "events" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."participant_id" AS "participant_id", "LHS"."participant_type_code" AS "participant_type_code", "LHS"."participant_details" AS "participant_details", "LHS"."event_id" AS "event_id", "LHS"."service_id" AS "service_id", "LHS"."event_details" AS "event_details" FROM (SELECT "LHS"."participant_id" AS "participant_id", "LHS"."participant_type_code" AS "participant_type_code", "LHS"."participant_details" AS "participant_details", "RHS"."event_id" AS "event_id", "RHS"."service_id" AS "service_id", "RHS"."event_details" AS "event_details" FROM "participants" AS "LHS" CROSS JOIN "events" AS "RHS") AS "LHS" INNER JOIN "participants_in_events" AS "RHS" ON ("LHS"."participant_id" = "RHS"."participant_id" AND "LHS"."event_id" = "RHS"."event_id")) WHERE ("participant_details" = 'Kenyatta Kuhn')) AS RHS WHERE (LHS.event_id = RHS.event_id AND LHS.service_id = RHS.service_id))) ORDER BY event_id, "event_id" NULLS LAST;

/*
Gold Result:
(1043,)
*/

-- Prediction Query
SELECT event_id FROM EVENTS EXCEPT SELECT T1.event_id FROM Participants_in_Events AS T1 JOIN Participants AS T2 ON T1.Participant_ID = T2.Participant_ID WHERE Participant_Details = 'Kenyatta Kuhn';

/*
Prediction Result:
*/