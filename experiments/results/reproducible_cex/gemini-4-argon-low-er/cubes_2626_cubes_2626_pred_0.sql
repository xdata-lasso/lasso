-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Services" ("Service_ID", "Service_Type_Code") VALUES (1, 'TypeA');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code") VALUES (2, 'TypeB');
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (1, 2, 'Event 1');
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (2, 1, 'Event 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_id, event_details FROM events ORDER BY service_id, events.event_id NULLS LAST;

/*
Gold Result:
(1, 'Event 2')
(2, 'Event 1')
*/

-- Prediction Query
SELECT service_id, event_details FROM EVENTS;

/*
Prediction Result:
(2, 'Event 1')
(1, 'Event 2')
*/