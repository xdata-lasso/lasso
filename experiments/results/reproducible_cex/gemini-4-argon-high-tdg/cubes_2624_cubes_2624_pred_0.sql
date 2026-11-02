-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (100, 'SVC_A');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (200, 'SVC_B');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (300, 'SVC_C');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (1, 'ORG', 'Alpha');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (2, 'IND', 'Beta');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (3, 'ORG', 'Gamma');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (3, 100, 'A_Event');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, 200, 'M_Event');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 300, 'Z_Event');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (10, 100, 'Ref_10');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (20, 200, 'Ref_20');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (25, 200, 'Ref_25');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (30, 300, 'Ref_30');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (50, 300, 'Ref_50');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (60, 300, 'Ref_60');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 1);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (20, 1);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (30, 1);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 2);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (20, 3);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (30, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id AS count___ FROM (SELECT LHS.event_id AS event_id, LHS.service_id AS service_id, LHS.event_details AS event_details, RHS.participant_id AS participant_id FROM events AS LHS INNER JOIN (SELECT participant_id, COUNT(DISTINCT event_id) AS n_distinct FROM participants_in_events GROUP BY participant_id) AS RHS ON (LHS.event_id = RHS.n_distinct)) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM EVENTS WHERE NOT event_id IN (SELECT event_id FROM Participants_in_Events);

/*
Prediction Result:
(6,)
*/