-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the maximum count (kills LIMIT 1 mutants) and tests ORDER BY direction (by inserting 'Z_Type' before 'A_Type').
-- Also tests extraneous joins with Participants_in_Events/Events/Services where 'B_Type' has the most event participations, while 'A_Type' and 'Z_Type' have the most participants.
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'B_Type');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (10, 1, 'Event 1');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (20, 1, 'Event 2');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (30, 1, 'Event 3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (1, 'Z_Type', 'Detail 1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (2, 'Z_Type', 'Detail 2');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (3, 'A_Type', 'Detail 3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (4, 'A_Type', 'Detail 4');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (5, 'B_Type', 'Detail 5');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 5);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (20, 5);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (30, 5);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code)) AS RHS) WHERE (n >= n_other) ORDER BY participant_type_code;

/*
Gold Result:
('A_Type',)
('Z_Type',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_Type',)
*/