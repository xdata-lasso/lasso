-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (1, '2023-01-10', 'Main Stadium', 'Opening Ceremony', 5000);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (2, '2023-01-15', 'City Hall', 'Press Conference', 200);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Zoe', 'Austria', '22', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Alice', 'USA', '45', 20);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Bob', 'Canada', '35', 10);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'Charlie', 'UK', '40', 15);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (5, 'Mona', 'Brazil', '30', 5);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (3, 1, 'Broadcast');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (4, 1, 'Print');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (4, 2, 'Online');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM journalist AS LHS WHERE NOT EXISTS(SELECT 1 FROM news_report AS RHS WHERE (LHS.journalist_id = RHS.journalist_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Mona',)
('Zoe',)
*/

-- Prediction Query
SELECT Name FROM journalist WHERE NOT journalist_ID IN (SELECT journalist_ID FROM news_report);

/*
Prediction Result:
('Zoe',)
('Alice',)
('Mona',)
*/