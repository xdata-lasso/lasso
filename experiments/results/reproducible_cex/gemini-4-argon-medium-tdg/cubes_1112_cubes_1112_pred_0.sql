-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by nationality (primary sort), journalist_ID (secondary sort with distinct Age values to detect ordering changes), and duplicates (to catch erroneous DISTINCT or GROUP BY).
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (3, 'Alice', 'Canada', '28', 4);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Bob', 'Canada', '42', 12);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Charlie', 'Canada', '42', 10);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (4, 'Diana', 'Brazil', '35', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, age FROM journalist ORDER BY nationality, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('Brazil', '35')
('Canada', '42')
('Canada', '42')
('Canada', '28')
*/

-- Prediction Query
SELECT Nationality, Age FROM journalist;

/*
Prediction Result:
('Canada', '42')
('Canada', '42')
('Canada', '28')
('Brazil', '35')
*/