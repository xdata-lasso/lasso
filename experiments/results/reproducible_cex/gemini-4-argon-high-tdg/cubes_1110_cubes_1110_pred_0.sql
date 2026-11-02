-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (1, '2023-01-01', 'Hall A', 'Gala', 500);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (2, '2023-01-02', 'Hall B', 'Summit', 1000);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (3, '2023-01-03', 'Hall C', 'Forum', 200);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Bob', 'France', '35', 10);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Alice', 'USA', '25', 5);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Charlie', 'USA', '45', 20);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'David', 'Zambia', '50', 25);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (2, 1, 'Host');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (2, 2, 'Reporter');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (2, 3, 'Editor');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (4, 1, 'Reporter');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (4, 2, 'Host');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT journalist_id, nationality, COUNT(*) AS n FROM journalist GROUP BY journalist_id, nationality) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('France',)
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/