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
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('pro_3f0d55', 'sta_741e5f');

-- Inserting into table: project_staff --
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (582.588439, 'pro_3f0d55', -2147483648, '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (165.344793, 'pro_3f0d55', -2147483648, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (833.684115, 'pro_3f0d55', -2147483648, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1.0, 'pro_3f0d55', -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_71d41a');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (171.746906, 'pro_3f0d55', -2147483648, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (557.512061, 'pro_3f0d55', -2147483648, '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (868.436572, 'pro_3f0d55', -2147483648, '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (537.136345, 'pro_3f0d55', -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_023d3f');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (795.366812, 'pro_3f0d55', -2147483648, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (882.963176, 'pro_3f0d55', -2147483648, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (711.020062, 'pro_3f0d55', -2147483648, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', NULL);

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (737.440743, 'pro_3f0d55', -2147483648, '2022-11-06 10:19:41+00:00', NULL, 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (179.378884, 'pro_3f0d55', -2147483648, '2022-08-02 13:58:36+00:00', NULL, 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (182.319045, 'pro_3f0d55', -2147483648, '2025-02-07 06:53:31+00:00', NULL, 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (666.330692, 'pro_3f0d55', -2147483648, '2020-05-25 18:19:31+00:00', '2021-12-31 07:20:26+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (133.007885, 'pro_3f0d55', -2147483648, '2020-08-22 06:30:10+00:00', '2024-02-29 12:08:41+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (345.718563, 'pro_3f0d55', -2147483648, '2024-05-04 23:07:19+00:00', '2021-05-18 10:50:30+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (587.783596, 'pro_3f0d55', -2147483648, NULL, '2024-10-02 15:57:32+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (627.258639, 'pro_3f0d55', -2147483648, NULL, '2024-10-26 11:04:11+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (963.351729, 'pro_3f0d55', -2147483648, NULL, '2024-03-03 15:52:53+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (950.466571, 'pro_3f0d55', -2147483648, '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (44.682291, 'pro_3f0d55', -2147483648, '2020-08-15 08:54:31+00:00', '2023-12-22 03:17:01+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (805.746877, 'pro_3f0d55', -2147483648, '2022-09-29 20:25:58+00:00', '2021-08-19 01:10:02+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (21.917736, 'pro_3f0d55', -2147483648, '2022-10-09 12:52:21+00:00', '2021-11-30 23:39:10+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (760.580899, 'pro_3f0d55', -2147483648, '2025-01-09 01:18:18+00:00', '2022-05-20 13:35:30+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (597.420508, 'pro_3f0d55', -2147483648, '2021-11-17 08:00:56+00:00', '2025-10-15 06:50:58+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (242.260296, 'pro_3f0d55', -2147483648, '2022-06-06 01:51:46+00:00', '2024-04-01 02:40:29+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (22.720462, 'pro_3f0d55', -2147483648, '2022-01-05 17:19:47+00:00', '2023-07-13 23:57:06+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (825.231787, 'pro_3f0d55', -2147483648, '2020-08-22 17:31:36+00:00', '2022-10-06 23:43:31+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (889.661694, 'pro_3f0d55', -2147483648, '2020-01-22 05:30:29+00:00', '2023-08-20 20:02:04+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (274.580687, 'pro_3f0d55', -2147483648, '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (300.875654, 'pro_3f0d55', -2147483648, '2021-11-25 10:04:53+00:00', '2025-06-28 05:56:56+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (552.838162, 'pro_3f0d55', -2147483648, '2021-08-05 01:19:54+00:00', '2025-11-19 11:50:18+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (958.92567, 'pro_3f0d55', -2147483648, '2021-05-27 14:39:41+00:00', '2021-07-01 18:29:24+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (763.856372, 'pro_3f0d55', -2147483648, '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (598.409165, 'pro_3f0d55', -2147483648, '2023-05-10 11:49:51+00:00', '2023-01-02 05:47:29+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (313.384575, 'pro_3f0d55', -2147483648, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 'pro_c1aee3');

INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (845.831524, 'pro_3f0d55', -2147483648, '2024-12-22 09:14:04+00:00', '2023-03-29 15:56:46+00:00', 'pro_c1aee3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT role_code FROM (SELECT LHS.role_code AS role_code, LHS.n AS n, LHS.maxn AS maxn, RHS.staff_id AS staff_id, RHS.date_from AS date_from, RHS.date_to AS date_to, RHS.other_details AS other_details FROM (SELECT role_code, n, MAX(n) OVER () AS maxn FROM (SELECT role_code, COUNT(*) AS n FROM project_staff GROUP BY role_code)) AS LHS INNER JOIN project_staff AS RHS ON (LHS.maxn = RHS.project_id AND LHS.role_code = RHS.role_code)) ORDER BY role_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT role_code FROM Project_Staff GROUP BY role_code ORDER BY COUNT(*) DESC, role_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('pro_3f0d55',)
*/