-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'John Williams', 90, 'USA', 70);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'Herbert von Karajan', 81, 'Austria', 60);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (3, 'Simon Rattle', 68, 'UK', 45);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (4, 'Gustavo Dudamel', 42, 'Venezuela', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "conductor" WHERE ("nationality" <> 'USA') ORDER BY name, conductor.conductor_id NULLS LAST;

/*
Gold Result:
('Gustavo Dudamel',)
('Herbert von Karajan',)
('Simon Rattle',)
*/

-- Prediction Query
SELECT Name FROM conductor WHERE Nationality <> 'USA';

/*
Prediction Result:
('Herbert von Karajan',)
('Simon Rattle',)
('Gustavo Dudamel',)
*/