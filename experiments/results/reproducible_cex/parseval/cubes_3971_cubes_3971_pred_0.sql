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
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (582.588439, 'role_cod_1', -2147483648, '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00', 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (486.033807, 'role_cod_1', -2147483648, '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (97.952323, 'role_cod_1', -2147483648, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (537.136345, 'role_cod_1', -2147483648, '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00', 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (38.937207, 'role_cod_1', -2147483648, '2024-02-11 16:43:27+00:00', '2025-06-13 15:31:02+00:00', 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (249.706432, 'role_cod_1', -2147483648, '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00', 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (797.015047, 'role_cod_1', -2147483648, '2022-01-21 14:23:36+00:00', '2022-10-06 13:20:05+00:00', NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (294.861575, 'role_cod_1', -2147483648, '2022-04-13 09:01:25+00:00', NULL, NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (994.117864, 'role_cod_1', -2147483648, '2022-01-03 02:42:55+00:00', NULL, NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (737.440743, 'role_cod_1', -2147483648, '2022-11-06 10:19:41+00:00', NULL, NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (303.05704, 'role_cod_1', -2147483648, '2021-01-23 18:11:33+00:00', NULL, 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (998.421621, 'role_cod_1', -2147483648, '2021-10-06 00:40:57+00:00', NULL, 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (986.066566, 'role_cod_1', -2147483648, '2025-09-01 05:13:03+00:00', NULL, 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (227.766936, 'role_cod_1', -2147483648, '2022-06-07 16:30:43+00:00', NULL, 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (75.403642, 'role_cod_1', -2147483648, '2022-10-15 07:04:26+00:00', NULL, 'pro_c49c8f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (992.733505, 'role_cod_1', -2147483648, '2021-05-18 10:50:30+00:00', NULL, 'pro_c49c8f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxdate_to AS date_to FROM (SELECT other_details, MAX(date_to) AS maxdate_to FROM project_staff GROUP BY other_details) ORDER BY date_to;

/*
Gold Result:
('2022-10-06 13:20:05+00:00',)
('2025-06-13 15:31:02+00:00',)
*/

-- Prediction Query
SELECT date_to FROM Project_Staff ORDER BY date_to DESC, Project_Staff.staff_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2025-06-13 15:31:02+00:00',)
*/