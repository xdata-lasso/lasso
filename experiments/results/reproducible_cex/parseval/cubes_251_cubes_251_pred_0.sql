-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_template_types --
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('tem_58a4f2', 'ref_91d919');

-- Inserting into table: templates --
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483648, 'tem_58a4f2', -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483647, 'tem_58a4f2', -664303813, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483646, 'tem_58a4f2', -1726781632, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483645, 'tem_58a4f2', 247012447, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483644, 'tem_58a4f2', 1610062532, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483643, 'tem_58a4f2', 1871297066, '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483642, 'tem_58a4f2', 89267185, '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483641, 'tem_58a4f2', -1633151678, '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483640, 'tem_58a4f2', 1268590800, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483639, 'tem_58a4f2', 1644814318, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483638, 'tem_58a4f2', 906324270, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483637, 'tem_58a4f2', 13244799, '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483636, 'tem_58a4f2', -1910425938, '2022-07-30 13:34:14+00:00', '2022-08-02 13:58:36+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483635, 'tem_58a4f2', -1610064545, '2020-03-11 00:23:16+00:00', '2025-02-07 06:53:31+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483634, 'tem_58a4f2', -1257178728, '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483633, 'tem_58a4f2', 907682809, '2021-12-08 15:32:00+00:00', '2025-04-09 18:22:58+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483632, 'tem_58a4f2', 2026480202, '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483631, 'tem_58a4f2', -1823627488, '2022-10-15 07:04:26+00:00', '2021-11-09 05:42:50+00:00', 'tem_5b67eb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "template_type_code", COUNT(*) AS "n" FROM "templates" GROUP BY "template_type_code") WHERE ("template_type_code" = 'CV') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Templates WHERE template_type_code = 'CV';

/*
Prediction Result:
(0,)
*/