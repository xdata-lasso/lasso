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

-- Inserting into table: document_types --
INSERT INTO "document_types" ("document_type_code", "document_description") VALUES ('document_1', 'doc_50e7b9');

-- Inserting into table: grants --
INSERT INTO "grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (1, -2147483648, 0.0001, '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'gra_dff9bd');

-- Inserting into table: organisation_types --
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('organisa_1', 'org_359f94');

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483648, 1, 'document_1', '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483647, 1, 'document_1', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483646, 1, 'document_1', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483645, 1, 'document_1', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483644, 1, 'document_1', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483643, 1, 'document_1', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483642, 1, 'document_1', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483641, 1, 'document_1', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483640, 1, 'document_1', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483639, 1, 'document_1', '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', NULL);

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483638, 1, 'document_1', '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00', NULL);

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483637, 1, 'document_1', '2022-07-05 02:28:20+00:00', '2025-08-22 00:34:24+00:00', NULL);

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483636, 1, 'document_1', '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483635, 1, 'document_1', '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483634, 1, 'document_1', '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483633, 1, 'document_1', '2020-06-20 11:35:06+00:00', '2021-07-11 07:27:32+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483632, 1, 'document_1', '2022-08-02 13:58:36+00:00', '2021-01-23 18:11:33+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483631, 1, 'document_1', '2020-03-11 00:23:16+00:00', '2025-02-07 06:53:31+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483630, 1, 'document_1', '2022-01-18 15:57:55+00:00', '2022-04-12 01:47:28+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483629, 1, 'document_1', '2025-09-01 05:13:03+00:00', '2025-03-03 08:26:45+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483628, 1, 'document_1', '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483627, 1, 'document_1', '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483626, 1, 'document_1', '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483625, 1, 'document_1', '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483624, 1, 'document_1', '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483623, 1, 'document_1', '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483622, 1, 'document_1', '2025-05-02 19:47:39+00:00', '2023-07-26 05:50:21+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483621, 1, 'document_1', '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483620, 1, 'document_1', '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483619, 1, 'document_1', '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483618, 1, 'document_1', '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483617, 1, 'document_1', '2023-12-22 03:17:01+00:00', '2024-05-26 02:52:16+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483616, 1, 'document_1', '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483615, 1, 'document_1', '2024-10-24 14:16:53+00:00', '2024-02-23 22:32:48+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483614, 1, 'document_1', '2025-09-21 09:36:38+00:00', '2023-05-17 17:49:21+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483613, 1, 'document_1', '2025-10-02 08:51:14+00:00', '2022-10-09 12:52:21+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483612, 1, 'document_1', '2024-01-27 22:01:59+00:00', '2021-09-24 11:50:48+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483611, 1, 'document_1', '2025-10-19 18:29:54+00:00', '2022-02-18 18:38:40+00:00', 'doc_43ff17');

INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (-2147483610, 1, 'document_1', '2021-11-17 08:00:56+00:00', '2025-10-15 06:50:58+00:00', 'doc_43ff17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grant_id, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT grant_id, other_details, COUNT(*) AS n FROM documents GROUP BY grant_id, other_details) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(1, 36)
*/

-- Prediction Query
SELECT grant_id, COUNT(*) FROM Documents GROUP BY grant_id ORDER BY COUNT(*) DESC, grant_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 39)
*/