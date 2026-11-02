-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journalist (journalist_id, name, nationality, age, years_working) VALUES (0, 'default2', 'default2', 'default2', 1), (2, 'default1', 'default1', 'default1', NULL), (1, 'default1', 'default2', NULL, NULL), (3, NULL, 'default1', 'default1', 2);
INSERT INTO event (event_id, date, venue, name, event_attendance) VALUES (2, 'default1', 'default1', 'default1', 2), (0, NULL, NULL, 'default2', 1), (1, 'default2', 'default2', 'default2', NULL), (3, 'default2', 'default1', NULL, 0), (4, NULL, 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM journalist AS LHS WHERE NOT EXISTS(SELECT 1 FROM news_report AS RHS WHERE (LHS.journalist_id = RHS.journalist_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM journalist WHERE NOT journalist_ID IN (SELECT journalist_ID FROM news_report);

/*
Prediction Result:
('default2',)
('default1',)
('default1',)
(None,)
*/