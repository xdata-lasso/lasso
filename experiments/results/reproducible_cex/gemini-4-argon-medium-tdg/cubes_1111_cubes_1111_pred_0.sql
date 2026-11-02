-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ORDER BY ASC vs DESC, duplicate names (DISTINCT vs ALL), and joining on Event_ID instead of journalist_ID.
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (1, '2023-01-01', 'Stadium', 'Event A', 1000);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (2, '2023-01-02', 'Arena', 'Event B', 2000);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Zack', 'USA', '30', 5);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Alice', 'UK', '25', 2);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (3, 'Bob', 'Canada', '40', 15);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (4, 'Alice', 'Australia', '28', 4);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (5, 'Charlie', 'USA', '35', 10);
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (3, 1, 'Host');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (5, 1, 'Reporter');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (5, 2, 'Reporter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM journalist AS LHS WHERE NOT EXISTS(SELECT 1 FROM news_report AS RHS WHERE (LHS.journalist_id = RHS.journalist_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM journalist WHERE NOT journalist_ID IN (SELECT journalist_ID FROM news_report);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/