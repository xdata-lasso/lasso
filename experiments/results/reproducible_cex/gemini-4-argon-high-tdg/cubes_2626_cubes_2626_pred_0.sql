-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (100, 'SVC_ALPHA');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (200, 'SVC_BETA');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (300, 'SVC_UNUSED');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (10, 'ORG', 'Acme Corp');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (20, 'IND', 'Jane Doe');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 200, 'Beta First');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, 100, 'Middle Event');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (3, 100, 'Zebra Event');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (4, 100, 'Alpha Event');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (5, 200, 'Beta First');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 20);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_id, event_details FROM events ORDER BY service_id, events.event_id NULLS LAST;

/*
Gold Result:
(100, 'Middle Event')
(100, 'Zebra Event')
(100, 'Alpha Event')
(200, 'Beta First')
(200, 'Beta First')
*/

-- Prediction Query
SELECT service_id, event_details FROM EVENTS;

/*
Prediction Result:
(200, 'Beta First')
(100, 'Middle Event')
(100, 'Zebra Event')
(100, 'Alpha Event')
(200, 'Beta First')
*/