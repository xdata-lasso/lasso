-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'Marriage');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (2, 'Funeral');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (3, 'Marriage');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (4, 'Baptism');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (101, 'Host', 'Alice');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (102, 'Guest', 'Bob');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 2, 'Memorial Speech');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, 1, 'Wedding Reception');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (3, 1, 'Bridal Procession');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (4, 4, 'Water Blessing');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 101);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 102);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "event_details" FROM (SELECT "LHS"."service_id" AS "service_id", "LHS"."service_type_code" AS "service_type_code", "RHS"."event_id" AS "event_id", "RHS"."event_details" AS "event_details" FROM (SELECT * FROM "services" WHERE ("service_type_code" = 'Marriage')) AS LHS LEFT JOIN events AS RHS ON (LHS.service_id = RHS.service_id)) ORDER BY event_details, "event_details" NULLS LAST;

/*
Gold Result:
(None,)
('Bridal Procession',)
('Wedding Reception',)
*/

-- Prediction Query
SELECT T1.event_details FROM EVENTS AS T1 JOIN Services AS T2 ON T1.Service_ID = T2.Service_ID WHERE T2.Service_Type_Code = 'Marriage';

/*
Prediction Result:
('Wedding Reception',)
('Bridal Procession',)
*/