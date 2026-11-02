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
INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483648, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', NULL, '2022-06-06 02:35:43+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483647, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', NULL, '2022-03-24 16:30:12+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483646, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', NULL, '2022-06-28 11:34:24+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483645, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', NULL, '2025-02-21 23:30:13+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483644, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2024-06-15 00:00:00+00:00', '2022-02-14 19:27:39+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (-2147483643, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2024-06-15 00:00:00+00:00', '2024-06-06 00:28:47+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (2, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2020-07-23 07:32:15+00:00', '2024-02-11 16:43:27+00:00', 'ass_2ab221');

INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (3, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00', 'ass_2ab221');

-- Inserting into table: maintenance_contracts --
INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (-2147483648, -2147483648, '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'mai_b1ea88');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minasset_acquired_date AS asset_acquired_date FROM (SELECT MIN(asset_acquired_date) AS minasset_acquired_date FROM assets) ORDER BY asset_acquired_date;

/*
Gold Result:
('2020-07-23 07:32:15+00:00',)
*/

-- Prediction Query
SELECT asset_acquired_date FROM Assets ORDER BY asset_acquired_date ASC LIMIT 1;

/*
Prediction Result:
(None,)
*/