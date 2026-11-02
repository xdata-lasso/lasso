-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Alice', 'USA', '35', 10);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Bob', 'UK', '30', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM journalist ORDER BY name, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM journalist ORDER BY Years_working ASC, journalist.journalist_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
*/