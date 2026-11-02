-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, NULL);
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (100, 'B_TYPE', 'D1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (50, 'A_TYPE', 'D2');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 1, 'E1');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, NULL, 'E2');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 100);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 100);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 50);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_id, participant_type_code, n AS count___ FROM (SELECT LHS.participant_id AS participant_id, LHS.n AS n, RHS.participant_type_code AS participant_type_code, RHS.participant_details AS participant_details FROM (SELECT participant_id, COUNT(*) AS n FROM participants_in_events GROUP BY participant_id) AS LHS LEFT JOIN participants AS RHS ON (LHS.participant_id = RHS.participant_id)) ORDER BY participant_id, participant_type_code NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, 1)
(50, 'A_TYPE', 1)
(100, 'B_TYPE', 2)
*/

-- Prediction Query
SELECT T1.Participant_ID, T1.Participant_Type_Code, COUNT(*) FROM Participants AS T1 JOIN Participants_in_Events AS T2 ON T1.Participant_ID = T2.Participant_ID GROUP BY T1.Participant_ID;

/*
Prediction Result:
(50, 'A_TYPE', 1)
(100, 'B_TYPE', 2)
*/