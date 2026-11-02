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
INSERT INTO "third_party_companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (1, '29001', 'thi_a15002', 'thi_8754eb', 'thi_e560f2');

-- Inserting into table: assets --
INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (1, 1, -2147483648, 'ass_0e2078', 'ass_2fcd94', 'ass_ed876e', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'ass_27f1de');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483647, 1, -2147483648, 'ass_a86b83', 'ass_fa1345', 'ass_33dccc', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'ass_feeba4');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (2, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2022-07-05 02:28:20+00:00', '2025-08-22 00:34:24+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (3, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (4, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (5, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (6, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (7, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (8, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-12-08 15:32:00+00:00', '2025-04-09 18:22:58+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (9, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-01-29 03:06:29+00:00', '2020-08-22 06:30:10+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (10, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-11-09 05:42:50+00:00', '2022-12-10 02:38:39+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (11, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (12, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (13, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2024-03-03 15:52:53+00:00', '2020-04-28 17:03:46+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (14, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (15, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2025-04-19 21:11:20+00:00', '2020-08-15 08:54:31+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (16, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (17, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2023-11-07 12:14:47+00:00', '2025-09-21 09:36:38+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (18, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2025-10-02 08:51:14+00:00', '2022-10-09 12:52:21+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (19, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (20, 1, 1, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2025-01-30 02:54:07+00:00', '2022-05-03 09:37:43+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (21, 1, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2024-12-28 10:57:01+00:00', '2022-03-17 22:33:35+00:00', 'ass_2ab221');

-- Inserting into table: maintenance_contracts --
INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (-2147483648, 1, '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'mai_b1ea88');

INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (1, 1, '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'mai_b1ea88');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT asset_acquired_date FROM (SELECT maintenance_contract_id AS asset_id, maintenance_contract_id, supplier_company_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details, supplier_company_id_other, asset_details_other, asset_make_other, asset_model_other, asset_acquired_date_other, asset_disposed_date_other, other_asset_details_other FROM (SELECT LHS.asset_id AS asset_id, LHS.maintenance_contract_id AS maintenance_contract_id, LHS.supplier_company_id AS supplier_company_id, LHS.asset_details AS asset_details, LHS.asset_make AS asset_make, LHS.asset_model AS asset_model, LHS.asset_acquired_date AS asset_acquired_date, LHS.asset_disposed_date AS asset_disposed_date, LHS.other_asset_details AS other_asset_details, RHS.supplier_company_id AS supplier_company_id_other, RHS.asset_details AS asset_details_other, RHS.asset_make AS asset_make_other, RHS.asset_model AS asset_model_other, RHS.asset_acquired_date AS asset_acquired_date_other, RHS.asset_disposed_date AS asset_disposed_date_other, RHS.other_asset_details AS other_asset_details_other FROM assets AS LHS INNER JOIN assets AS RHS ON (LHS.maintenance_contract_id = RHS.asset_id AND LHS.supplier_company_id = RHS.maintenance_contract_id))) ORDER BY asset_acquired_date;

/*
Gold Result:
*/

-- Prediction Query
SELECT asset_acquired_date FROM Assets ORDER BY asset_acquired_date ASC LIMIT 1;

/*
Prediction Result:
('2020-04-05 14:43:51+00:00',)
*/