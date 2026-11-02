-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'Zubin Mehta', 85, 'India', 60);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'Leonard Bernstein', 72, 'USA', 45);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (3, 'Gustavo Dudamel', 40, 'Venezuela', 22);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (4, 'Carlos Kleiber', 74, 'Austria', 30);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (5, 'Carlos Kleiber', 55, 'Germany', 25);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (6, 'Simon Rattle', 66, 'UK', 40);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (10, 1, 'Israel Philharmonic', 'Decca', 1936.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (11, 1, 'Los Angeles Philharmonic', 'Sony', 1919.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (12, 2, 'New York Philharmonic', 'Columbia', 1842.0, 'Vinyl');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (13, 3, 'Simon Bolivar Symphony', 'DG', 1975.0, 'CD');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (100, 10, 'Classical', '2020-05-01', 2.5, '1', '12%');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (101, 12, 'Gala', '2020-06-15', 4.1, '2', '18%');
INSERT INTO "show" ("Performance_ID", "Show_ID", "If_first_show", "Result", "Attendance") VALUES (100, 1000, 1, 'Success', 1500.0);
INSERT INTO "show" ("Performance_ID", "Show_ID", "If_first_show", "Result", "Attendance") VALUES (101, 1001, 0, 'Sold Out', 2200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "conductor" WHERE ("nationality" <> 'USA') ORDER BY name, conductor.conductor_id NULLS LAST;

/*
Gold Result:
('Carlos Kleiber',)
('Carlos Kleiber',)
('Gustavo Dudamel',)
('Simon Rattle',)
('Zubin Mehta',)
*/

-- Prediction Query
SELECT Name FROM conductor WHERE Nationality <> 'USA';

/*
Prediction Result:
('Zubin Mehta',)
('Gustavo Dudamel',)
('Carlos Kleiber',)
('Carlos Kleiber',)
('Simon Rattle',)
*/