-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_template_types --
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('tem_490107', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('lhs_e8aa6b', 'ref_91d919');

-- Inserting into table: templates --
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483648, 'tem_490107', -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483647, 'tem_490107', -664303813, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483646, 'tem_490107', -1726781632, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1, 'lhs_e8aa6b', 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_7bf544');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483644, 'tem_490107', NULL, '2024-09-28 03:06:45+00:00', '2021-10-04 22:30:57+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483643, 'tem_490107', NULL, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483642, 'tem_490107', NULL, '2020-04-30 23:22:06+00:00', '2024-01-16 07:29:50+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483641, 'tem_490107', -734455130, '2020-07-23 07:32:15+00:00', '2024-02-11 16:43:27+00:00', NULL);

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483640, 'tem_490107', 1160656988, '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', NULL);

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483639, 'tem_490107', 1914020640, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', NULL);

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483638, 'tem_490107', -1670923962, '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483637, 'lhs_e8aa6b', 1908028688, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483636, 'tem_490107', -1659388584, '2020-06-20 11:35:06+00:00', '2021-07-11 07:27:32+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483635, 'tem_490107', -841692980, NULL, '2021-07-20 10:41:36+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483634, 'tem_490107', 429706943, NULL, '2022-01-18 15:57:55+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483633, 'tem_490107', 1236688122, NULL, '2021-08-20 16:50:24+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483632, 'tem_490107', 907682809, '2021-12-08 15:32:00+00:00', NULL, 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483631, 'tem_490107', -918961358, '2021-01-29 03:06:29+00:00', NULL, 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483630, 'tem_490107', -1823627488, '2022-10-15 07:04:26+00:00', NULL, 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (2, 'tem_490107', 44952191, '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (3, 'tem_490107', 1419861592, '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00', 'tem_5b67eb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT template_type_code, COUNT(*) AS n FROM templates GROUP BY template_type_code) AS RHS ON (LHS.version_number = RHS.n AND LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT template_type_code FROM Templates GROUP BY template_type_code ORDER BY COUNT(*) DESC, template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('tem_490107',)
*/