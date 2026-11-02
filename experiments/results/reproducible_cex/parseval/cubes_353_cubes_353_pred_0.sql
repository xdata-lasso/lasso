-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: conductor --
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1, 'con_1b2d89', 1, 'con_29c745', 1);

INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (-2147483647, 'con_6e8138', 1, 'con_037a0d', 1);

INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (-2147483646, 'q_1_f64229', -55602865, 'swwqcgsk', 1610062532);

INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (-2147483645, 'q_1_f64229', -106629402, 'u7', -734455130);

INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (-1, '4h', 7719, 'ia2yp', -1670923962);

INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (0, 'rwbbp6luhvd', 0, 'tti', -1364429300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM conductor ORDER BY age DESC, conductor.conductor_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('4h',)
*/

-- Prediction Query
SELECT Name FROM conductor ORDER BY Year_of_Work DESC, conductor.conductor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_f64229',)
*/