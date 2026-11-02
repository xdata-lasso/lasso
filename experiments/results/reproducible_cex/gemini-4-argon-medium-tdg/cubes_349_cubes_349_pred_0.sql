-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'John Williams', 90, 'USA', 1952);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'Hans Zimmer', 65, 'Germany', 1977);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (3, 'Ennio Morricone', 91, 'Italy', 1946);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (4, 'Howard Shore', 76, 'Canada', 1969);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (1, 1, 'Orch 1', 'Alpha Records', 1980.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (2, 1, 'Orch 2', 'Zeta Music', 1990.0, 'Vinyl');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (3, 2, 'Orch 3', 'Zeta Music', 1995.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (4, 2, 'Orch 4', 'Zeta Music', 2000.0, 'Digital');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (5, 3, 'Orch 5', 'Beta Sound', 1985.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (6, 3, 'Orch 6', 'Beta Sound', 1988.0, 'Vinyl');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (7, 3, 'Orch 7', 'Beta Sound', 1992.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (8, 4, 'Orch 8', 'Beta Sound', 1999.0, 'Digital');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (9, 4, 'Orch 9', 'Gamma Audio', 2005.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (10, 4, 'Orch 10', 'Gamma Audio', 2010.0, 'Digital');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT record_company_other AS record_company FROM (SELECT LHS.record_company AS record_company, LHS.n AS n, RHS.record_company AS record_company_other, RHS.n AS n_other FROM (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS LHS CROSS JOIN (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS RHS) WHERE (n < n_other) ORDER BY record_company;

/*
Gold Result:
('Beta Sound',)
('Gamma Audio',)
('Zeta Music',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC, Record_Company NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta Sound',)
*/