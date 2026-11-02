-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard GROUP BY vs. primary key GROUP BY, and ordering by Years_working/Age vs. ordering by primary key/count.
-- Notice journalist_ID = 1 has nationality 'USA' (count 1), while 'UK' has 2 journalists (IDs 2 and 3).
-- A mutant that groups only by Nationality will pick 'UK'.
-- A mutant that joins with news_report will pick 'France' (ID 4 has 3 reports) or filter out ID 1 (0 reports).
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (101, '2023-01-01', 'Arena A', 'Concert', 5000);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (102, '2023-01-02', 'Arena B', 'Match', 10000);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (103, '2023-01-03', 'Arena C', 'Gala', 200);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Zack', 'USA', '25', 2);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Alice', 'UK', '40', 15);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (3, 'Bob', 'UK', '50', 25);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (4, 'Charlie', 'France', '35', 10);
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (2, 101, 'Interview');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (4, 101, 'Article');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (4, 102, 'Broadcast');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (4, 103, 'Photography');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT journalist_id, nationality, COUNT(*) AS n FROM journalist GROUP BY journalist_id, nationality) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('UK',)
*/