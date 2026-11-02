-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (0, 'Brian Ramirez', 1033, 'North Macedonia', 1034);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (150, 'Brian Ramirez', 1036, 'Paraguay', 1037);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (20, 'Kimberly Sanchez', 1039, 'New Caledonia', 1040);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM conductor ORDER BY name, conductor.conductor_id NULLS LAST;

/*
Gold Result:
('Brian Ramirez',)
('Brian Ramirez',)
('Kimberly Sanchez',)
*/

-- Prediction Query
SELECT Name FROM conductor ORDER BY Year_of_Work DESC, conductor.conductor_id NULLS LAST;

/*
Prediction Result:
('Kimberly Sanchez',)
('Brian Ramirez',)
('Brian Ramirez',)
*/