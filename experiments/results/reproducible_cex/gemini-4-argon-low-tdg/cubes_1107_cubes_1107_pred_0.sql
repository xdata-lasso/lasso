-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for Years_working (2, 3, 10, 11) and basic ordering
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Alice', 'USA', '30', 2);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Bob', 'Canada', '35', 3);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (3, 'Charlie', 'Mexico', '40', 10);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (4, 'Diana', 'UK', '45', 11);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (5, 'Eve', 'France', '32', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM journalist WHERE (years_working > 10 OR years_working < 3) ORDER BY nationality;

/*
Gold Result:
('UK',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM journalist WHERE Years_working > 10 INTERSECT SELECT Nationality FROM journalist WHERE Years_working < 3;

/*
Prediction Result:
*/