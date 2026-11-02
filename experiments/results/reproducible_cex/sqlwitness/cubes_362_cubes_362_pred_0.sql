-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orchestra (orchestra_id, conductor_id, orchestra, record_company, year_of_founded, major_record_format) VALUES (0, NULL, 'default2', 'default1', 0.0, 'default1'), (1, NULL, NULL, NULL, NULL, 'default2'), (2, NULL, 'default1', 'default2', NULL, 'default2');
INSERT INTO performance (performance_id, orchestra_id, type, date, "official_ratings_(millions)", weekly_rank, share) VALUES (1, NULL, 'default1', NULL, 0.0, 'default1', 'default2'), (0, 1, 'default1', 'default2', NULL, 'default1', NULL);
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