-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Services" ("service_id", "service_type_code") VALUES (10, '14');
INSERT INTO "Services" ("service_id", "service_type_code") VALUES (9, '14');
INSERT INTO "Participants" ("participant_id", "participant_type_code", "participant_details") VALUES (12, '14', '14');
INSERT INTO "Participants" ("participant_id", "participant_type_code", "participant_details") VALUES (11, '14', '14');
INSERT INTO "Events" ("event_id", "service_id", "event_details") VALUES (14, 9, '14');
INSERT INTO "Events" ("event_id", "service_id", "event_details") VALUES (13, 10, '14');
INSERT INTO "Participants_in_Events" ("event_id", "participant_id") VALUES (14, 11);
INSERT INTO "Participants_in_Events" ("event_id", "participant_id") VALUES (13, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM (SELECT event_id, n, MAX(n) OVER () AS maxn FROM (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id)) WHERE (maxn <= n) ORDER BY event_id;

/*
Gold Result:
(13,)
(14,)
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(13,)
*/