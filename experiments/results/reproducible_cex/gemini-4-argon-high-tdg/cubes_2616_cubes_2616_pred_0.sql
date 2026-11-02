-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'SRV_X');
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (2, 'SRV_Y');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (101, 1, 'Opening Ceremony');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (102, 2, 'Closing Ceremony');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (1, 'A', 'Alice');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (2, 'A', 'Aaron');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (3, 'A', 'Amanda');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (4, 'B', 'Bob');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (5, 'B', 'Bella');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (6, 'C', 'Charlie');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (7, 'C', 'Clara');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (8, 'C', 'Carl');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (9, 'C', 'Cindy');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (10, 'D', 'David');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (101, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (102, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (101, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.participant_type_code AS participant_type_code_other, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS RHS) WHERE (n > n_other) ORDER BY participant_type_code;

/*
Gold Result:
('A',)
('A',)
('B',)
('C',)
('C',)
('C',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('C',)
*/