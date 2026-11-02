-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journalist (journalist_id, name, nationality, age, years_working) VALUES (0, 'default1', 'default1', NULL, 0), (1, NULL, 'default1', NULL, 1), (2, NULL, NULL, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, age FROM journalist ORDER BY nationality, journalist.journalist_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', None)
('default1', None)
*/

-- Prediction Query
SELECT Nationality, Age FROM journalist;

/*
Prediction Result:
('default1', None)
('default1', None)
(None, 'default1')
*/