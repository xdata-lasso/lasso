-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: services --
INSERT INTO "services" ("service_id", "service_type_code") VALUES (-2147483648, 'ser_ae7abd');

-- Inserting into table: participants --
INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483648, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483647, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483646, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483645, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483644, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483643, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483642, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483641, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483640, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483639, 'par_cb0f9d', 'par_ab627b');

INSERT INTO "participants" ("participant_id", "participant_type_code", "participant_details") VALUES (-2147483638, 'par_cb0f9d', 'par_ab627b');

-- Inserting into table: events --
INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (1, -2147483648, 'eve_d1aa45');

INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (2, -2147483648, 'eve_d1aa45');

INSERT INTO "events" ("event_id", "service_id", "event_details") VALUES (3, -2147483648, 'eve_d1aa45');

-- Inserting into table: participants_in_events --
INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483648);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483647);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483646);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483645);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483644);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483643);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483646);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483648);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (3, -2147483646);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483647);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483644);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (3, -2147483644);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483642);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483641);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (3, -2147483648);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483640);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (2, -2147483645);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (3, -2147483647);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483639);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483640);

INSERT INTO "participants_in_events" ("event_id", "participant_id") VALUES (1, -2147483638);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT event_id_other AS event_id FROM (SELECT LHS.event_id AS event_id, LHS.participant_id AS participant_id, RHS.event_id AS event_id_other FROM participants_in_events AS LHS INNER JOIN (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id) AS RHS ON (LHS.event_id = RHS.n)) ORDER BY event_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/