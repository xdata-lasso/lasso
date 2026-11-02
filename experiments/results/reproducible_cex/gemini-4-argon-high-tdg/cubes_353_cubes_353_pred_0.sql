-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'Conductor_MinID', 50, 'USA', 20);
INSERT INTO conductor ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'Conductor_MaxAge', 102, 'UK', 25);
INSERT INTO conductor ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (3, 'Conductor_MinAge', 9, 'France', 15);
INSERT INTO conductor ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (4, 'Conductor_MaxYoW', 88, 'Germany', 60);
INSERT INTO conductor ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (5, 'Conductor_MinYoW', 40, 'Italy', 2);
INSERT INTO conductor ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (6, 'Conductor_MaxID', 55, 'Austria', 30);
INSERT INTO orchestra ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (1, 1, 'Symphony One', 'Decca', 1950.0, 'CD');
INSERT INTO orchestra ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (2, 4, 'Symphony Four', 'Sony', 2010.0, 'Vinyl');
INSERT INTO performance ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (1, 1, 'Live', '2020-05-01', 15.5, '1', '25%');
INSERT INTO show ("Performance_ID", "Show_ID", "If_first_show", "Result", "Attendance") VALUES (1, 1, 1, 'Success', 1200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM conductor ORDER BY age DESC, conductor.conductor_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Conductor_MaxAge',)
*/

-- Prediction Query
SELECT Name FROM conductor ORDER BY Year_of_Work DESC, conductor.conductor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Conductor_MaxYoW',)
*/