-- Schema DDL
CREATE TABLE "Third_Party_Companies" ("company_id" INTEGER PRIMARY KEY, "company_type" TEXT(5), "company_name" TEXT(255), "company_address" TEXT(255), "other_company_details" TEXT(255));

CREATE TABLE "Maintenance_Contracts" ("maintenance_contract_id" INTEGER PRIMARY KEY, "maintenance_contract_company_id" INTEGER, "contract_start_date" DATETIME, "contract_end_date" DATETIME, "other_contract_details" TEXT(255), FOREIGN KEY ("maintenance_contract_company_id") REFERENCES "Third_Party_Companies" ("company_id"));

CREATE TABLE "Skills" ("skill_id" INTEGER PRIMARY KEY, "skill_code" TEXT(20), "skill_description" TEXT(255));

CREATE TABLE "Assets" ("asset_id" INTEGER PRIMARY KEY, "supplier_company_id" INTEGER, "maintenance_contract_id" INTEGER, "asset_details" TEXT(255), "asset_make" TEXT(20), "asset_model" TEXT(20), "asset_acquired_date" DATETIME, "asset_disposed_date" DATETIME, "other_asset_details" TEXT(255), FOREIGN KEY ("supplier_company_id") REFERENCES "Third_Party_Companies" ("company_id"), FOREIGN KEY ("maintenance_contract_id") REFERENCES "Maintenance_Contracts" ("maintenance_contract_id"));

CREATE TABLE "Asset_Parts" ("asset_id" INTEGER, "part_id" INTEGER, FOREIGN KEY ("asset_id") REFERENCES "Assets" ("asset_id"), FOREIGN KEY ("part_id") REFERENCES "Parts" ("part_id"));

CREATE TABLE "Maintenance_Engineers" ("engineer_id" INTEGER PRIMARY KEY, "company_id" INTEGER, "first_name" TEXT(50), "last_name" TEXT(50), "other_details" TEXT(255), FOREIGN KEY ("company_id") REFERENCES "Third_Party_Companies" ("company_id"));

CREATE TABLE "Engineer_Skills" ("skill_id" INTEGER, "engineer_id" INTEGER, FOREIGN KEY ("skill_id") REFERENCES "Skills" ("skill_id"), FOREIGN KEY ("engineer_id") REFERENCES "Maintenance_Engineers" ("engineer_id"));

CREATE TABLE "Fault_Log" ("fault_log_entry_id" INTEGER PRIMARY KEY, "recorded_by_staff_id" INTEGER, "asset_id" INTEGER, "fault_log_entry_datetime" DATETIME, "fault_description" TEXT(255), "other_fault_details" TEXT(255), FOREIGN KEY ("recorded_by_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("asset_id") REFERENCES "Assets" ("asset_id"));

CREATE TABLE "Engineer_Visits" ("engineer_visit_id" INTEGER PRIMARY KEY, "contact_staff_id" INTEGER, "engineer_id" INTEGER, "fault_log_entry_id" INTEGER, "fault_status" TEXT(10), "visit_start_datetime" DATETIME, "visit_end_datetime" DATETIME, "other_visit_details" TEXT(255), FOREIGN KEY ("contact_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("engineer_id") REFERENCES "Maintenance_Engineers" ("engineer_id"), FOREIGN KEY ("fault_log_entry_id") REFERENCES "Fault_Log" ("fault_log_entry_id"));

CREATE TABLE "Part_Faults" ("part_fault_id" INTEGER PRIMARY KEY, "part_id" INTEGER, "fault_short_name" TEXT(20), "fault_description" TEXT(255), "other_fault_details" TEXT(255), FOREIGN KEY ("part_id") REFERENCES "Parts" ("part_id"));

CREATE TABLE "Fault_Log_Parts" ("fault_log_entry_id" INTEGER, "part_fault_id" INTEGER, "fault_status" TEXT(10), FOREIGN KEY ("fault_log_entry_id") REFERENCES "Fault_Log" ("fault_log_entry_id"), FOREIGN KEY ("part_fault_id") REFERENCES "Part_Faults" ("part_fault_id"));

CREATE TABLE "Skills_Required_To_Fix" ("skill_id" INTEGER, "part_fault_id" INTEGER, FOREIGN KEY ("skill_id") REFERENCES "Skills" ("skill_id"), FOREIGN KEY ("part_fault_id") REFERENCES "Part_Faults" ("part_fault_id"));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_name" TEXT(255), "gender" INTEGER, "other_staff_details" TEXT(255));

CREATE TABLE "Parts" ("part_id" INTEGER PRIMARY KEY, "part_name" TEXT(255), "chargeable_yn" INTEGER, "chargeable_amount" INTEGER, "other_part_details" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: third_party_companies --
INSERT INTO "third_party_companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (-2147483648, '29001', 'thi_a15002', 'thi_8754eb', 'thi_e560f2');

-- Inserting into table: assets --
INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483648, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 'ass_2ab221');

-- Inserting into table: maintenance_engineers --
INSERT INTO "maintenance_engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (-2147483648, -2147483648, 'mai_e804ba', 'mai_d74b9f', 'mai_12e93a');

-- Inserting into table: fault_log --
INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (-2147483648, 1, -2147483648, '2020-04-30 03:21:27+00:00', 'fau_f9eb6c', 'fau_e0336b');

-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (1, 'lhs_e0c411', 1, 'lhs_8373e5');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483647, 'lhs_35043b', 1, 'lhs_755259');

-- Inserting into table: maintenance_contracts --
INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (-2147483648, -2147483648, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00', 'mai_b1ea88');

-- Inserting into table: engineer_visits --
INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483648, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483647, 1, -2147483648, -2147483648, 'eng_6c3910', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483646, 1, -2147483648, -2147483648, 'eng_6c3910', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483645, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483644, 1, -2147483648, -2147483648, 'eng_6c3910', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483643, 1, -2147483648, -2147483648, 'eng_6c3910', '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483642, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483641, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483640, 1, -2147483648, -2147483648, 'eng_6c3910', '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483639, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483638, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483637, 1, -2147483648, -2147483648, 'eng_6c3910', '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483636, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-12-08 15:32:00+00:00', '2025-04-09 18:22:58+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483635, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-01-29 03:06:29+00:00', '2020-08-22 06:30:10+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483634, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-11-09 05:42:50+00:00', '2022-12-10 02:38:39+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483633, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483632, 1, -2147483648, -2147483648, 'eng_6c3910', '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483631, 1, -2147483648, -2147483648, 'eng_6c3910', '2024-03-03 15:52:53+00:00', '2020-04-28 17:03:46+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483630, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00', NULL);

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483629, 1, -2147483648, -2147483648, 'eng_6c3910', '2025-04-19 21:11:20+00:00', '2020-08-15 08:54:31+00:00', NULL);

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483628, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', NULL);

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483627, 1, -2147483648, -2147483648, 'eng_6c3910', '2023-11-07 12:14:47+00:00', '2025-09-21 09:36:38+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483626, 1, -2147483648, -2147483648, 'eng_6c3910', '2025-10-02 08:51:14+00:00', '2022-10-09 12:52:21+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483625, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483624, 1, -2147483648, -2147483648, 'eng_6c3910', '2025-01-30 02:54:07+00:00', '2022-05-03 09:37:43+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483623, 1, -2147483648, -2147483648, 'eng_6c3910', '2024-12-28 10:57:01+00:00', '2022-03-17 22:33:35+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483622, 1, -2147483648, -2147483648, 'eng_6c3910', '2024-02-28 04:46:49+00:00', '2022-06-06 01:51:46+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483621, 1, -2147483648, -2147483648, 'eng_6c3910', '2020-03-11 14:09:37+00:00', '2022-01-05 17:19:47+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483620, 1, -2147483648, -2147483648, 'eng_6c3910', '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483619, 1, -2147483648, -2147483648, 'eng_6c3910', '2021-08-01 11:21:15+00:00', '2021-03-04 19:22:02+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483618, 1, -2147483648, -2147483648, 'eng_6c3910', '2023-08-20 20:02:04+00:00', '2023-08-19 04:29:46+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483617, 1, -2147483648, -2147483648, 'eng_6c3910', '2024-10-18 05:00:47+00:00', '2023-03-18 23:06:49+00:00', 'eng_3d7239');

INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (-2147483616, 1, -2147483648, -2147483648, 'eng_6c3910', '2025-06-28 05:56:56+00:00', '2021-12-20 12:18:45+00:00', 'eng_3d7239');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT staff_name, n AS count___ FROM (SELECT LHS.staff_id AS staff_id, LHS.staff_name AS staff_name, LHS.gender AS gender, LHS.other_staff_details AS other_staff_details, RHS.other_visit_details AS other_visit_details, RHS.n AS n FROM staff AS LHS INNER JOIN (SELECT contact_staff_id, other_visit_details, COUNT(*) AS n FROM engineer_visits GROUP BY contact_staff_id, other_visit_details) AS RHS ON (LHS.staff_id = RHS.contact_staff_id)) ORDER BY staff_name;

/*
Gold Result:
('lhs_e0c411', 3)
('lhs_e0c411', 30)
*/

-- Prediction Query
SELECT T1.staff_name, COUNT(*) FROM Staff AS T1 JOIN Engineer_Visits AS T2 ON T1.staff_id = T2.contact_staff_id GROUP BY T1.staff_name;

/*
Prediction Result:
('lhs_e0c411', 33)
*/