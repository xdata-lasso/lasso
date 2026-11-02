-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'SRV_1');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (1, 1, 'Evt 1');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (2, 1, 'Evt 2');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (3, 1, 'Evt 3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (1, 'TYPE_Z', 'D1');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (2, 'TYPE_Z', 'D2');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (3, 'TYPE_Z', 'D3');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (4, 'TYPE_A', 'D4');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (5, 'TYPE_A', 'D5');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (6, 'TYPE_A', 'D6');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (7, 'TYPE_B', 'D7');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (8, 'TYPE_B', 'D8');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (9, 'TYPE_C', 'D9');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 9);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (2, 9);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (3, 9);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (1, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code)) AS RHS) WHERE (n >= n_other) ORDER BY participant_type_code;

/*
Gold Result:
('TYPE_A',)
('TYPE_Z',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('TYPE_A',)
*/