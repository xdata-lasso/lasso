-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (101, '2023-05-01', 'London Stadium', 'Spring Gala', 5000);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (102, '2023-06-15', 'Cardiff Arena', 'Summer Fest', 3200);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Charlie', 'Wales', '30', 2);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Alice', 'England', '40', 8);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (3, 'David', 'England', '20', 6);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (4, 'Bob', 'Wales', '50', 4);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (5, 'Eve', 'Scotland', '25', 3);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (6, 'Frank', 'Ireland', '35', 7);
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (1, 101, 'Broadcast');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (1, 102, 'Interview');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (5, 101, 'Article');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "journalist" WHERE ("nationality" = 'England' OR "nationality" = 'Wales') ORDER BY name, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
('David',)
*/

-- Prediction Query
SELECT Name FROM journalist WHERE Nationality = 'England' OR Nationality = 'Wales';

/*
Prediction Result:
('Charlie',)
('Alice',)
('David',)
('Bob',)
*/