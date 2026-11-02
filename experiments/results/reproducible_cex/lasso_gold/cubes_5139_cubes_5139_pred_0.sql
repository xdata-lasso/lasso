-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1020, 'discover', 'play');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1021, 'early', 'agreement');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1022, 'mouth', 'option');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1029, 'offer', 'list');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1030, 'kind', 'perform');
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (1031, 'discussion', 'fall');
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1023, 'decide');
INSERT INTO "services" ("service_id", "service_type_code") VALUES (1032, 'table');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1024, 1023, 'sense');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1025, 1023, 'rate');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1026, 1023, 'science');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1033, 1032, 'true');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1034, 1032, 'according');
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1035, 1032, 'song');
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1024, 1020);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1024, 1021);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1024, 1022);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1033, 1029);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1033, 1030);
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1033, 1031);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM (SELECT event_id, n, MAX(n) OVER () AS maxn FROM (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id)) WHERE (maxn <= n) ORDER BY event_id;

/*
Gold Result:
(1024,)
(1033,)
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(1024,)
*/