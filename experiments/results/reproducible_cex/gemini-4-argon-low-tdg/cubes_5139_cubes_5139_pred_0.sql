-- Schema DDL
CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15));

CREATE TABLE "Participants" ("Participant_ID" INTEGER PRIMARY KEY, "Participant_Type_Code" TEXT(15), "Participant_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Service_ID" INTEGER, "Event_Details" TEXT(255), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Participants_in_Events" ("Event_ID" INTEGER, "Participant_ID" INTEGER, PRIMARY KEY ("Event_ID", "Participant_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Participant_ID") REFERENCES "Participants" ("Participant_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the maximum count (catches LIMIT 1 mutants),
-- ordering of results (catches DESC or missing ORDER BY),
-- and ensures events with fewer participants are excluded.
INSERT INTO Services (Service_ID, Service_Type_Code) VALUES (1, 'TypeA');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (101, 'P_A', 'Alice');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (102, 'P_B', 'Bob');
INSERT INTO Participants (Participant_ID, Participant_Type_Code, Participant_Details) VALUES (103, 'P_C', 'Charlie');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (10, 1, 'Event Ten');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (20, 1, 'Event Twenty');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (30, 1, 'Event Thirty');
INSERT INTO Events (Event_ID, Service_ID, Event_Details) VALUES (40, 1, 'Event Forty');
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (30, 101);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (30, 102);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (30, 103);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 101);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 102);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (10, 103);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (20, 101);
INSERT INTO Participants_in_Events (Event_ID, Participant_ID) VALUES (20, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM (SELECT event_id, n, MAX(n) OVER () AS maxn FROM (SELECT event_id, COUNT(*) AS n FROM participants_in_events GROUP BY event_id)) WHERE (maxn <= n) ORDER BY event_id;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT Event_ID FROM Participants_in_Events GROUP BY Event_ID ORDER BY COUNT(*) DESC, Event_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/