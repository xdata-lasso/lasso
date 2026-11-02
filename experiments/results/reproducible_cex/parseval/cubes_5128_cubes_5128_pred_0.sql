-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: participants --
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483648, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483647, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483646, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483645, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483644, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483643, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483642, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483641, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483640, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483639, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483638, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483637, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483636, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483635, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483634, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483633, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483632, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483631, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483630, NULL, 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483629, NULL, 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483628, NULL, 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483627, NULL, 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483626, NULL, 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483625, NULL, 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483624, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483623, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483622, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483621, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483620, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483619, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483618, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483617, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483616, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483615, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483614, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483613, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483612, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483611, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483610, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483609, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483608, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483607, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483606, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483605, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483604, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483603, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483602, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483601, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483600, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483599, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483598, 'par_6255f9', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483597, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483596, 'par_b9e425', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483595, 'par_b9e425', 'par_ab627b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT participant_type_code FROM (SELECT LHS.participant_type_code AS participant_type_code, LHS.n AS n, RHS.n AS n_other FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT participant_type_code, COUNT(*) AS n FROM participants GROUP BY participant_type_code)) AS RHS) WHERE (n >= n_other) ORDER BY participant_type_code;

/*
Gold Result:
('par_6255f9',)
('par_b9e425',)
*/

-- Prediction Query
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY COUNT(*) DESC, participant_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('par_6255f9',)
*/