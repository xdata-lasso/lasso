-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Alice', 'US', '30', 5);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Bob', 'UK', '40', 10);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Charlie', 'UK', '35', 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT journalist_id, nationality, COUNT(*) AS n FROM journalist GROUP BY journalist_id, nationality) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('US',)
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('UK',)
*/