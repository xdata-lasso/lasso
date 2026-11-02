-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'TypeA');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 1, 'Success');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "service_type_code" FROM (SELECT "LHS"."service_id" AS "service_id", "LHS"."service_type_code" AS "service_type_code", "RHS"."event_id" AS "event_id", "RHS"."event_details" AS "event_details" FROM "services" AS "LHS" INNER JOIN (SELECT * FROM "events" WHERE ("event_details" = 'Success' OR "event_details" <> 'Fail')) AS RHS ON (LHS.service_id = RHS.service_id)) ORDER BY service_type_code, "service_type_code" NULLS LAST;

/*
Gold Result:
('TypeA',)
*/

-- Prediction Query
SELECT T1.service_type_code FROM services AS T1 JOIN EVENTS AS T2 ON T1.service_id = T2.service_id WHERE T2.event_details = 'Success' INTERSECT SELECT T1.service_type_code FROM services AS T1 JOIN EVENTS AS T2 ON T1.service_id = T2.service_id WHERE T2.event_details = 'Fail';

/*
Prediction Result:
*/