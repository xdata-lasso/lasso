-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO event (event_id, date, venue, name, event_attendance) VALUES (1, 'default1', 'default1', 'default2', 0), (0, 'default1', 'default2', 'default1', NULL), (2, 'default1', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, name, venue FROM event ORDER BY date, event.event_id NULLS LAST;

/*
Gold Result:
('default1', 'default1', 'default2')
('default1', 'default2', 'default1')
('default1', None, 'default2')
*/

-- Prediction Query
SELECT Date, Name, venue FROM event ORDER BY Event_Attendance DESC, event.event_id NULLS LAST;

/*
Prediction Result:
('default1', 'default2', 'default1')
('default1', 'default1', 'default2')
('default1', None, 'default2')
*/