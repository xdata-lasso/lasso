-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journalist (journalist_id, name, nationality, age, years_working) VALUES (0, 'default2', 'default1', 'default1', NULL), (1, 'default1', 'default1', 'default2', 1), (2, NULL, 'default2', NULL, 1), (3, NULL, 'default1', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM journalist ORDER BY name, journalist.journalist_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM journalist ORDER BY Years_working ASC, journalist.journalist_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default1',)
(None,)
(None,)
*/