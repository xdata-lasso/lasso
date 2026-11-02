-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (inverse relationship between count and alphabetical order), duplicate retention (SELECT vs SELECT DISTINCT), and spurious joins with Participants_in_Events.
INSERT INTO "Services" ("Service_ID", "Service_Type_Code") VALUES (1, 'SRV_1');
INSERT INTO "Events" ("Event_ID", "Service_ID", "Event_Details") VALUES (1, 1, 'Event 1');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (1, 'Type_C', 'P1');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (2, 'Type_B', 'P2');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (3, 'Type_B', 'P3');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (4, 'Type_A', 'P4');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (5, 'Type_A', 'P5');
INSERT INTO "Participants" ("Participant_ID", "Participant_Type_Code", "Participant_Details") VALUES (6, 'Type_A', 'P6');
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (1, 1);
INSERT INTO "Participants_in_Events" ("Event_ID", "Participant_ID") VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.participant_type_code AS participant_type_code_other, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS RHS) WHERE (n > n_other) ORDER BY participant_type_code;

/*
Gold Result:
('Type_A',)
('Type_A',)
('Type_B',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Type_A',)
*/