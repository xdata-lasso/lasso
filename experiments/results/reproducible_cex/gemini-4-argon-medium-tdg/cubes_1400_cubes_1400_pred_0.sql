-- Schema DDL
CREATE TABLE "Document_Types" ("document_type_code" TEXT(10) PRIMARY KEY, "document_description" TEXT(255));

CREATE TABLE "Documents" ("document_id" INTEGER PRIMARY KEY, "grant_id" INTEGER, "document_type_code" TEXT(10), "sent_date" DATETIME, "response_received_date" DATETIME, "other_details" TEXT(255), FOREIGN KEY ("grant_id") REFERENCES "Grants" ("grant_id"), FOREIGN KEY ("document_type_code") REFERENCES "Document_Types" ("document_type_code"));

CREATE TABLE "Grants" ("grant_id" INTEGER PRIMARY KEY, "organisation_id" INTEGER, "grant_amount" REAL(19, 4), "grant_start_date" DATETIME, "grant_end_date" DATETIME, "other_details" TEXT(255), FOREIGN KEY ("organisation_id") REFERENCES "Organisations" ("organisation_id"));

CREATE TABLE "Organisation_Types" ("organisation_type" TEXT(10) PRIMARY KEY, "organisation_type_description" TEXT(255));

CREATE TABLE "Organisations" ("organisation_id" INTEGER PRIMARY KEY, "organisation_type" TEXT(10), "organisation_details" TEXT(255), FOREIGN KEY ("organisation_type") REFERENCES "Organisation_Types" ("organisation_type"));

CREATE TABLE "Project_Outcomes" ("outcome_code" TEXT(10), "project_id" INTEGER, "outcome_details" TEXT(255), FOREIGN KEY ("outcome_code") REFERENCES "Research_Outcomes" ("outcome_code"), FOREIGN KEY ("project_id") REFERENCES "Projects" ("project_id"));

CREATE TABLE "Project_Staff" ("staff_id" REAL PRIMARY KEY, "role_code" TEXT(10), "project_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, "other_details" TEXT(255), FOREIGN KEY ("role_code") REFERENCES "Staff_Roles" ("role_code"), FOREIGN KEY ("project_id") REFERENCES "Projects" ("project_id"));

CREATE TABLE "Projects" ("project_id" INTEGER PRIMARY KEY, "organisation_id" INTEGER, "project_details" TEXT(255), FOREIGN KEY ("organisation_id") REFERENCES "Organisations" ("organisation_id"));

CREATE TABLE "Research_Outcomes" ("outcome_code" TEXT(10) PRIMARY KEY, "outcome_description" TEXT(255));

CREATE TABLE "Research_Staff" ("staff_id" INTEGER PRIMARY KEY, "employer_organisation_id" INTEGER, "staff_details" TEXT(255), FOREIGN KEY ("employer_organisation_id") REFERENCES "Organisations" ("organisation_id"));

CREATE TABLE "Staff_Roles" ("role_code" TEXT(10) PRIMARY KEY, "role_description" TEXT(255));

CREATE TABLE "Tasks" ("task_id" INTEGER PRIMARY KEY, "project_id" INTEGER, "task_details" TEXT(255), "eg Agree Objectives" TEXT(1), FOREIGN KEY ("project_id") REFERENCES "Projects" ("project_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (>= 6000.0 vs > 6000.0 vs < 6000.0), SUM aggregation across multiple rows vs MAX/MIN/AVG, and INNER JOIN vs LEFT JOIN (organisations without grants).
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('TYPE1', 'Research Inst');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (1, 'TYPE1', 'Org Boundary Exact');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (2, 'TYPE1', 'Org Multi-Grant Sum');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (3, 'TYPE1', 'Org Just Below Boundary');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (4, 'TYPE1', 'Org No Grants');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (101, 1, 6000.0, '2023-01-01', '2023-12-31', 'Exact boundary single grant');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (102, 2, 2500.0, '2023-01-01', '2023-06-30', 'Part 1');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (103, 2, 3500.5, '2023-07-01', '2023-12-31', 'Part 2');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (104, 3, 5999.99, '2023-01-01', '2023-12-31', 'Just under 6000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organisation_id, organisation_details FROM (SELECT organisation_details, organisation_id, SUM(grant_amount) AS sumgrant_amount FROM (SELECT LHS.grant_id AS grant_id, LHS.organisation_id AS organisation_id, LHS.grant_amount AS grant_amount, LHS.grant_start_date AS grant_start_date, LHS.grant_end_date AS grant_end_date, LHS.other_details AS other_details, RHS.organisation_type AS organisation_type, RHS.organisation_details AS organisation_details FROM grants AS LHS INNER JOIN organisations AS RHS ON (LHS.organisation_id = RHS.organisation_id)) GROUP BY organisation_details, organisation_id) WHERE (sumgrant_amount >= 6000.0) ORDER BY organisation_id, organisation_details NULLS LAST;

/*
Gold Result:
(1, 'Org Boundary Exact')
(2, 'Org Multi-Grant Sum')
*/

-- Prediction Query
SELECT T2.organisation_id, T2.organisation_details FROM Grants AS T1 JOIN Organisations AS T2 ON T1.organisation_id = T2.organisation_id GROUP BY T2.organisation_id HAVING SUM(T1.grant_amount) > 6000;

/*
Prediction Result:
(2, 'Org Multi-Grant Sum')
*/