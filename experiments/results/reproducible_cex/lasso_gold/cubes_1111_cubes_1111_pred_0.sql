-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1015, 'Shannon Ray', 'Mauritania', 'capital', 1016);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1017, 'Renee Blair', 'Switzerland', 'production', 1017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM journalist AS LHS WHERE NOT EXISTS(SELECT 1 FROM news_report AS RHS WHERE (LHS.journalist_id = RHS.journalist_id))) ORDER BY name;

/*
Gold Result:
('Renee Blair',)
('Shannon Ray',)
*/

-- Prediction Query
SELECT Name FROM journalist WHERE NOT journalist_ID IN (SELECT journalist_ID FROM news_report);

/*
Prediction Result:
('Shannon Ray',)
('Renee Blair',)
*/