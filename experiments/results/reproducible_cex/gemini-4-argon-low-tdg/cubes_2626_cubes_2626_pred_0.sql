-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by service_id, tie-breaking by event_id, and inverse correlation between event_details and event_id to catch wrong secondary sort columns.
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'TypeA');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (2, 'TypeB');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (10, 2, 'Detail_A');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (20, 1, 'Detail_Z');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (30, 1, 'Detail_M');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_id, event_details FROM events ORDER BY service_id, events.event_id NULLS LAST;

/*
Gold Result:
(1, 'Detail_Z')
(1, 'Detail_M')
(2, 'Detail_A')
*/

-- Prediction Query
SELECT service_id, event_details FROM EVENTS;

/*
Prediction Result:
(2, 'Detail_A')
(1, 'Detail_Z')
(1, 'Detail_M')
*/