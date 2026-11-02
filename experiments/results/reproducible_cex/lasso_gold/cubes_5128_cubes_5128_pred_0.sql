-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1001, 'purpose', 'brother');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1002, 'purpose', 'ago');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1003, 'purpose', 'site');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1004, 'face', 'election');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1005, 'face', 'dog');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1006, 'face', 'chair');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code)) AS RHS) WHERE (n >= n_other) ORDER BY participant_type_code;

/*
Gold Result:
('face',)
('purpose',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('face',)
*/