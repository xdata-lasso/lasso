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
-- Inserting into table: organisations --
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (-2147483648, 'organisa_1', 'org_fd61f4');

-- Inserting into table: projects --
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (-2147483648, -2147483648, 'pro_be1e25');

-- Inserting into table: organisation_types --
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('organisa_1', 'org_359f94');

-- Inserting into table: staff_roles --
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('role_cod_1', 'sta_741e5f');

-- Inserting into table: project_staff --
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (345.329712, 'role_cod_1', -2147483648, NULL, '2022-03-24 16:30:12+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (292.730571, 'role_cod_1', -2147483648, NULL, '2024-11-14 12:35:58+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (475.173408, 'role_cod_1', -2147483648, NULL, '2020-11-05 04:59:51+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (86.520366, 'role_cod_1', -2147483648, NULL, '2020-07-23 07:32:15+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (268.82475, 'role_cod_1', -2147483648, '2024-06-15 00:00:00+00:00', '2020-01-15 18:18:33+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (797.015047, 'role_cod_1', -2147483648, '2024-06-15 00:00:00+00:00', '2022-01-21 14:23:36+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (2.0, 'role_cod_1', -2147483648, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (3.0, 'role_cod_1', -2147483648, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'pro_c1aee3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mindate_from AS date_from FROM (SELECT MIN(date_from) AS mindate_from FROM project_staff) ORDER BY date_from;

/*
Gold Result:
('2020-04-05 14:43:51+00:00',)
*/

-- Prediction Query
SELECT date_from FROM Project_Staff ORDER BY date_from ASC, Project_Staff.staff_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/