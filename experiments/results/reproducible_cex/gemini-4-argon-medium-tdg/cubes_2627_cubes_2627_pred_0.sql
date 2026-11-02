-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'TYPE_A');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (10, 'P_A', 'Alice');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (11, 'P_B', 'Bob');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (12, 'P_A', 'Charlie');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, 1, 'Event Two');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (5, 1, 'Event Five');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (10, 1, 'Event Ten');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 11);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 12);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (5, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (5, 11);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT event_id_other AS event_id FROM (SELECT LHS.event_id AS event_id, LHS.participant_id AS participant_id, RHS.event_id AS event_id_other FROM participants_in_events AS LHS INNER JOIN (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id) AS RHS ON (LHS.event_id = RHS.n)) ORDER BY event_id;

/*
Gold Result:
(5,)
(10,)
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/