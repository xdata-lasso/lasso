-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Nationality, secondary tie-breaking by journalist_ID, duplicate rows (catches DISTINCT/GROUP BY mutants), and unreferenced rows (catches INNER JOIN with news_report mutants).
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (1, '2023-05-01', 'Stadium', 'Final', 50000);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (10, 'Alice', 'USA', '30', 5);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Bob', 'USA', '45', 20);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (5, 'Charlie', 'Canada', '25', 2);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (8, 'David', 'Canada', '25', 8);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Eve', 'UK', '35', 10);
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (10, 1, 'Broadcast');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, age FROM journalist ORDER BY nationality, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('Canada', '25')
('Canada', '25')
('UK', '35')
('USA', '45')
('USA', '30')
*/

-- Prediction Query
SELECT Nationality, Age FROM journalist;

/*
Prediction Result:
('UK', '35')
('USA', '45')
('Canada', '25')
('Canada', '25')
('USA', '30')
*/