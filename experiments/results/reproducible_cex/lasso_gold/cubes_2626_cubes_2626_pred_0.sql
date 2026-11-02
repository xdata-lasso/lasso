-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1007, 'face');
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1006, 'dog');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1007, 1007, 'chair');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1009, 1006, 'election');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_id, event_details FROM events ORDER BY service_id, events.event_id NULLS LAST;

/*
Gold Result:
(1006, 'election')
(1007, 'chair')
*/

-- Prediction Query
SELECT service_id, event_details FROM EVENTS;

/*
Prediction Result:
(1007, 'chair')
(1006, 'election')
*/