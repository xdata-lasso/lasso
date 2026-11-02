-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty performance table: COUNT(*) OVER () returns 0 rows (unlike regular COUNT(*) which returns 1 row with 0).
-- Also includes rows in other tables to catch queries querying the wrong table.
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('1', 'Alice', 'USA', 'Violin');
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('2', 'Bob', 'UK', 'Cello');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM performance ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM performance;

/*
Prediction Result:
(0,)
*/