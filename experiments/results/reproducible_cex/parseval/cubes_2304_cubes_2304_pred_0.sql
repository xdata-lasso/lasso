-- Schema DDL
CREATE TABLE "Ref_Document_Types" ("Document_Type_Code" TEXT(15) PRIMARY KEY, "Document_Type_Name" TEXT(255), "Document_Type_Description" TEXT(255));

CREATE TABLE "Ref_Budget_Codes" ("Budget_Type_Code" TEXT(15) PRIMARY KEY, "Budget_Type_Description" TEXT(255));

CREATE TABLE "Projects" ("Project_ID" INTEGER PRIMARY KEY, "Project_Details" TEXT(255));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Project_ID" INTEGER, "Document_Type_Code" TEXT(15), "Document_Date" DATETIME, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Project_ID") REFERENCES "Projects" ("Project_ID"), FOREIGN KEY ("Document_Type_Code") REFERENCES "Ref_Document_Types" ("Document_Type_Code"));

CREATE TABLE "Statements" ("Statement_ID" INTEGER PRIMARY KEY, "Statement_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Documents" ("Document_ID"));

CREATE TABLE "Documents_with_Expenses" ("Document_ID" INTEGER PRIMARY KEY, "Budget_Type_Code" TEXT(15), "Document_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"), FOREIGN KEY ("Budget_Type_Code") REFERENCES "Ref_Budget_Codes" ("Budget_Type_Code"));

CREATE TABLE "Accounts" ("Account_ID" INTEGER PRIMARY KEY, "Statement_ID" INTEGER, "Account_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Statements" ("Statement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483648, -2147483648, 'doc_534ee6', '2024-12-15 00:56:33+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483647, -2147483648, 'doc_534ee6', '2021-05-28 17:00:04+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483646, -2147483648, 'doc_534ee6', '2022-06-06 02:35:43+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483645, -2147483648, 'doc_534ee6', '2023-01-16 20:10:41+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483644, -2147483648, 'doc_534ee6', '2020-04-30 03:21:27+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483643, -2147483648, 'doc_534ee6', '2022-06-28 11:34:24+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483642, -2147483648, 'doc_534ee6', '2024-11-14 12:35:58+00:00', 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483641, -2147483648, 'doc_534ee6', '2025-02-21 23:30:13+00:00', 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483640, -2147483648, 'doc_534ee6', '2024-01-16 07:29:50+00:00', 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483639, -2147483648, 'doc_534ee6', '2025-11-08 19:01:33+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483638, -2147483648, 'doc_534ee6', '2020-09-25 19:25:33+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483637, -2147483648, 'doc_534ee6', '2025-06-13 15:31:02+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483636, -2147483648, 'doc_534ee6', '2022-04-15 05:01:35+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483635, -2147483648, 'doc_534ee6', '2020-01-15 18:18:33+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483634, -2147483648, 'doc_534ee6', '2023-03-21 21:13:18+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483633, -2147483648, 'doc_534ee6', '2022-10-06 13:20:05+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483632, -2147483648, 'doc_534ee6', '2020-12-10 17:36:20+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483631, -2147483648, 'doc_534ee6', '2025-08-22 00:34:24+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483630, -2147483648, 'doc_534ee6', '2022-12-20 09:53:17+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483629, -2147483648, 'doc_534ee6', '2020-03-08 22:40:47+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (-2147483628, -2147483648, 'doc_534ee6', '2024-04-12 00:38:47+00:00', 'doc_a80aa9', 'doc_3a0a1c', 'doc_3b822f');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('doc_534ee6', 'ref_4df9bb', 'ref_df47b1');

-- Inserting into table: projects --
INSERT INTO "projects" ("project_id", "project_details") VALUES (-2147483648, 'pro_a03dfc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code, n AS count___ FROM (SELECT document_type_code, other_details, COUNT(*) AS n FROM documents GROUP BY document_type_code, other_details) ORDER BY document_type_code, count___ NULLS LAST;

/*
Gold Result:
('doc_534ee6', 3)
('doc_534ee6', 18)
*/

-- Prediction Query
SELECT document_type_code, COUNT(*) FROM Documents GROUP BY document_type_code;

/*
Prediction Result:
('doc_534ee6', 21)
*/