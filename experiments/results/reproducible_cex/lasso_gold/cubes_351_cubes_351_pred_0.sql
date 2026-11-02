-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1035, 'Juan Calderon', 1036, 'Niger', 1037);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1038, 'Darren Roberts', 1037, 'Bangladesh', 1038);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "conductor" WHERE ("nationality" <> 'USA') ORDER BY name, conductor.conductor_id NULLS LAST;

/*
Gold Result:
('Darren Roberts',)
('Juan Calderon',)
*/

-- Prediction Query
SELECT Name FROM conductor WHERE Nationality <> 'USA';

/*
Prediction Result:
('Juan Calderon',)
('Darren Roberts',)
*/