-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'David Kim', 60, 'Korea', 35);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (1, 1, 'Seoul Chamber', 'Sony', 2000.0, 'Digital');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (1, 1, 'Opening', '2023-04-01', 10.0, '1', '18%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(attendance) OVER () AS avg_attendance_ FROM show ORDER BY avg_attendance_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(Attendance) FROM SHOW;

/*
Prediction Result:
(None,)
*/