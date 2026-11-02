-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'TypeA');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (10, 'P1', 'Det1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (20, 'P2', 'Det2');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (30, 'P3', 'Det3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (40, 'P4', 'Det4');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 1, 'Ev1');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, 1, 'Ev2');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (4, 1, 'Ev4');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (5, 1, 'Ev5');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (4, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (5, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 20);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 20);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (5, 30);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 40);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 40);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (4, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id AS count___ FROM (SELECT LHS.event_id AS event_id, LHS.service_id AS service_id, LHS.event_details AS event_details, RHS.participant_id AS participant_id FROM events AS LHS INNER JOIN (SELECT participant_id, COUNT(DISTINCT event_id) AS n_distinct FROM participants_in_events GROUP BY participant_id) AS RHS ON (LHS.event_id = RHS.n_distinct)) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM EVENTS WHERE NOT event_id IN (SELECT event_id FROM Participants_in_Events);

/*
Prediction Result:
(0,)
*/