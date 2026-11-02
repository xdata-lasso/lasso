-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Services" ("service_id", "service_type_code") VALUES (12, '1');
INSERT INTO "Services" ("service_id", "service_type_code") VALUES (11, '1');
INSERT INTO "Participants" ("participant_id", "participant_type_code", "participant_details") VALUES (14, '20', '1');
INSERT INTO "Participants" ("participant_id", "participant_type_code", "participant_details") VALUES (13, NULL, '1');
INSERT INTO "Events" ("event_id", "service_id", "event_details") VALUES (16, 12, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.participant_type_code AS participant_type_code_other, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS RHS) WHERE (n > n_other) ORDER BY participant_type_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('20',)
*/