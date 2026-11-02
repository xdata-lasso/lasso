-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests multiple distinct counts (1, 2, 3), out-of-order codes vs counts, and duplicate output rows (DISTINCT vs ALL).
-- Expected output: 'A', 'A', 'Z' (since count('A')=3 > 2, 1 and count('Z')=2 > 1).
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (1, 'M', 'Detail 1');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (2, 'Z', 'Detail 2');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (3, 'Z', 'Detail 3');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (4, 'A', 'Detail 4');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (5, 'A', 'Detail 5');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (6, 'A', 'Detail 6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.participant_type_code AS participant_type_code_other, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS RHS) WHERE (n > n_other) ORDER BY participant_type_code;

/*
Gold Result:
('A',)
('A',)
('Z',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/