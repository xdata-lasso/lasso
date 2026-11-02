-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: services --
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1, 'Marriage');

INSERT INTO "services" ("service_id", "service_type_code") VALUES (-2147483647, 'Marriage');

-- Inserting into table: events --
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1, 1, 'rhs_ca91ed');

INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (-2147483647, 1, 'rhs_0a2b7d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "event_details" FROM (SELECT "LHS"."service_id" AS "service_id", "LHS"."service_type_code" AS "service_type_code", "RHS"."event_id" AS "event_id", "RHS"."event_details" AS "event_details" FROM (SELECT * FROM "services" WHERE ("service_type_code" = 'Marriage')) AS LHS LEFT JOIN events AS RHS ON (LHS.service_id = RHS.service_id)) ORDER BY event_details, "event_details" NULLS LAST;

/*
Gold Result:
(None,)
('rhs_0a2b7d',)
('rhs_ca91ed',)
*/

-- Prediction Query
SELECT T1.event_details FROM EVENTS AS T1 JOIN Services AS T2 ON T1.Service_ID = T2.Service_ID WHERE T2.Service_Type_Code = 'Marriage';

/*
Prediction Result:
('rhs_0a2b7d',)
('rhs_ca91ed',)
*/