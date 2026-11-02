-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Ties for maximum participants, plus an event with fewer participants, and an event with zero participants.
-- Tests: LIMIT 1 mutants, tie-handling, ORDER BY event_id, and LEFT JOIN vs INNER JOIN on Events.
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'TypeA');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (10, 'P1', 'Alice');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (20, 'P2', 'Bob');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (30, 'P1', 'Charlie');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (100, 1, 'Event 100 - 1 participant');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (200, 1, 'Event 200 - 3 participants');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (300, 1, 'Event 300 - 3 participants');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (400, 1, 'Event 400 - 0 participants');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (100, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (200, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (200, 20);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (200, 30);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (300, 10);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (300, 20);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (300, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM (SELECT event_id, n, MAX(n) OVER () AS maxn FROM (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id)) WHERE (maxn <= n) ORDER BY event_id;

/*
Gold Result:
(200,)
(300,)
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(200,)
*/