-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'Svc_1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (1, 'Type_Z', 'Z1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (2, 'Type_Z', 'Z2');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (3, 'Type_Z', 'Z3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (4, 'Type_M', 'M1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (5, 'Type_M', 'M2');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (6, 'Type_M', 'M3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (7, 'Type_A', 'A1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (8, 'Type_A', 'A2');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (100, 1, 'Main Event');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (100, 7);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (100, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code)) AS RHS) WHERE (n >= n_other) ORDER BY participant_type_code;

/*
Gold Result:
('Type_M',)
('Type_Z',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Type_M',)
*/