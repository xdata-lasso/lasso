-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1052, 'Daniel Bright', 1053, 'Malawi', 1054);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1057, 'Rebecca Henderson', 1058, 'Bahrain', 1059);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1062, 'Shannon Smith', 1063, 'Saint Helena', 1064);
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (0, 1052, 'minute', 'Campos Inc', 1056.5, 'claim');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (150, 1057, 'image', 'Campos Inc', 1061.5, 'enter');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (20, 1062, 'building', 'Carter and Sons', 1066.5, 'grow');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT record_company FROM orchestra ORDER BY record_company, orchestra.orchestra_id NULLS LAST;

/*
Gold Result:
('Campos Inc',)
('Campos Inc',)
('Carter and Sons',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC, orchestra.orchestra_id NULLS LAST;

/*
Prediction Result:
('Carter and Sons',)
('Campos Inc',)
('Campos Inc',)
*/