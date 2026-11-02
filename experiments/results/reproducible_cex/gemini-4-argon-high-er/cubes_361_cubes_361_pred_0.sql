-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'John Doe', 50, 'USA', 20);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (1, 1, 'Orchestra A', 'Alpha', 1900.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (2, 1, 'Orchestra B', 'Beta', 2000.0, 'CD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT record_company FROM orchestra ORDER BY record_company, orchestra.orchestra_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC, orchestra.orchestra_id NULLS LAST;

/*
Prediction Result:
('Beta',)
('Alpha',)
*/