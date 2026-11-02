-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO conductor (conductor_id, name, age, nationality, year_of_work) VALUES (2008, 'default2', 1, NULL, 0), (2007, 'default2', 0, 'default2', 2007), (1, 'default1', 0, NULL, 2007), (2009, 'default2', 2008, NULL, 2008), (0, 'default2', 1, 'default2', NULL), (2, 'default1', 2007, NULL, 1), (3, 'default1', 2007, 'default1', 0), (4, 'default2', 2007, 'default2', 2009), (5, 'default1', 2007, 'default2', NULL), (6, NULL, 2008, 'default2', 2007), (7, NULL, 2009, NULL, 0), (8, 'default1', 2008, NULL, 2008);
INSERT INTO orchestra (orchestra_id, conductor_id, orchestra, record_company, year_of_founded, major_record_format) VALUES (2008, NULL, 'default2', NULL, 2009.0, 'default2'), (2007, 2007, NULL, 'default2', 1.0, NULL), (1, NULL, 'default2', 'default2', 0.0, NULL), (2009, 2, 'default2', 'default2', 2008.0, 'default1'), (0, 2008, NULL, NULL, 0.0, 'default1'), (2, 5, 'default1', NULL, 2009.0, NULL), (3, 3, 'default1', 'default1', 2007.0, NULL), (4, 3, NULL, NULL, NULL, 'default2'), (5, 8, 'default2', 'default1', 0.0, NULL), (6, 7, 'default2', 'default1', 2009.0, 'default1'), (7, 3, 'default1', 'default1', 2007.0, 'default1'), (8, 2009, 'default1', NULL, 1.0, NULL), (9, 5, 'default1', 'default2', 2008.0, 'default2'), (10, 0, 'default1', 'default2', 2007.0, NULL), (11, NULL, 'default1', 'default2', 0.0, NULL), (12, 2009, 'default2', 'default2', 2008.0, 'default2'), (13, 2008, NULL, NULL, 2008.0, 'default1'), (14, 2009, 'default2', 'default2', NULL, 'default2'), (15, 0, NULL, 'default1', 0.0, 'default2'), (16, NULL, NULL, 'default1', 0.0, 'default2'), (17, NULL, 'default1', 'default2', 2009.0, 'default2'), (18, 3, 'default2', NULL, 1.0, NULL), (19, 4, NULL, 'default2', 2009.0, 'default1'), (20, 4, 'default1', NULL, 2008.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.conductor_id AS conductor_id, LHS.name AS name, LHS.age AS age, LHS.nationality AS nationality, LHS.year_of_work AS year_of_work, RHS.orchestra_id AS orchestra_id, RHS.orchestra AS orchestra, RHS.record_company AS record_company, RHS.year_of_founded AS year_of_founded, RHS.major_record_format AS major_record_format FROM conductor AS LHS INNER JOIN (SELECT * FROM orchestra WHERE (year_of_founded > 2008.0)) AS RHS ON (LHS.conductor_id = RHS.conductor_id)) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID WHERE Year_of_Founded > 2008;

/*
Prediction Result:
('default1',)
(None,)
('default2',)
*/