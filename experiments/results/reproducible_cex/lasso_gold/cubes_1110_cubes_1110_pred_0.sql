-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1009, 'Jennifer Cole', 'Hong Kong', 'bill', 1013);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1010, 'Sean Blake', 'Hong Kong', 'her', 1024.0);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1011, 'Jay Ramirez', 'Hong Kong', 'throw', 1035.0);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1012, 'Phillip Garcia', 'Hong Kong', 'guy', 1046.0);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1017, NULL, 'Aruba', 'recently', 1021);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1018, NULL, 'Aruba', 'drive', 1032.0);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1019, NULL, 'Aruba', 'spring', 1043.0);
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1020, NULL, 'Aruba', 'figure', 1054.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT journalist_id, nationality, COUNT(*) AS n FROM journalist GROUP BY journalist_id, nationality) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('Hong Kong',)
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aruba',)
*/