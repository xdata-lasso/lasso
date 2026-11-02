-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1001, 'Allison Hill', 1004, 'Antarctica (the territory South of 60 deg S)', 1007);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1002, 'Noah Rhodes', 1011.0, 'Bermuda', 1018.0);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1003, 'Angie Henderson', 1018.0, 'Cuba', 1029.0);
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1010, 1001, 'early', 'Hoffman Ltd', 1013.5, 'rate');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1011, 1001, 'mouth', 'Hoffman Ltd', 1024.5, 'science');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1012, 1001, 'play', 'Hoffman Ltd', 1035.5, 'offer');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1016, 1001, 'kind', 'Ramirez, Booth and Blake', 1019.5, 'collection');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1017, 1001, 'discussion', 'Ramirez, Booth and Blake', 1030.5, 'save');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1018, 1001, 'list', 'Ramirez, Booth and Blake', 1041.5, 'knowledge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT record_company_other AS record_company FROM (SELECT LHS.record_company AS record_company, LHS.n AS n, RHS.record_company AS record_company_other, RHS.n AS n_other FROM (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS LHS CROSS JOIN (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS RHS) WHERE (n < n_other) ORDER BY record_company;

/*
Gold Result:
*/

-- Prediction Query
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC, Record_Company NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hoffman Ltd',)
*/