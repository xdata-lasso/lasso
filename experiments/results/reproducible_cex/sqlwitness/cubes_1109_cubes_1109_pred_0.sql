-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journalist (journalist_id, name, nationality, age, years_working) VALUES (0, 'default2', 'Wales', 'default2', 1), (1, 'England', 'Wales', 'default1', 1), (2, 'Wales', NULL, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "journalist" WHERE ("nationality" = 'England' OR "nationality" = 'Wales') ORDER BY name, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('England',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM journalist WHERE Nationality = 'England' OR Nationality = 'Wales';

/*
Prediction Result:
('default2',)
('England',)
*/