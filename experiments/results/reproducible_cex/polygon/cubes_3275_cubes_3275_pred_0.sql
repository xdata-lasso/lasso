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
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (38, '37', '37', '37', '37');
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (44, '37', '37', '37', '37');
INSERT INTO "Maintenance_Contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (37, NULL, 37, 37, '37');
INSERT INTO "Maintenance_Contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (38, 44, 37, 37, '37');
INSERT INTO "Skills" ("skill_id", "skill_code", "skill_description") VALUES (22, '37', '37');
INSERT INTO "Skills" ("skill_id", "skill_code", "skill_description") VALUES (21, '37', '37');
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (36, 38, 37, '39', '40', '41', NULL, 42, '43');
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (37, 44, 38, '45', '46', '47', NULL, 49, '50');
INSERT INTO "Asset_Parts" ("asset_id", "part_id") VALUES (37, 24);
INSERT INTO "Maintenance_Engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (25, 44, '37', '37', '37');
INSERT INTO "Engineer_Skills" ("skill_id", "engineer_id") VALUES (21, 25);
INSERT INTO "Engineer_Skills" ("skill_id", "engineer_id") VALUES (21, 25);
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (27, 30, 37, 37, '37', '37');
INSERT INTO "Engineer_Visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (32, 30, 25, 27, '37', 37, 37, '37');
INSERT INTO "Part_Faults" ("part_fault_id", "part_id", "fault_short_name", "fault_description", "other_fault_details") VALUES (33, 24, '37', '37', '37');
INSERT INTO "Fault_Log_Parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (NULL, 33, '37');
INSERT INTO "Skills_Required_To_Fix" ("skill_id", "part_fault_id") VALUES (NULL, 33);
INSERT INTO "Staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (29, '37', 37, '37');
INSERT INTO "Staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (30, '37', 37, '37');
INSERT INTO "Parts" ("part_id", "part_name", "chargeable_yn", "chargeable_amount", "other_part_details") VALUES (23, '37', 37, 37, '37');
INSERT INTO "Parts" ("part_id", "part_name", "chargeable_yn", "chargeable_amount", "other_part_details") VALUES (24, '37', 37, 37, '37');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT asset_acquired_date FROM (SELECT maintenance_contract_id AS asset_id, maintenance_contract_id, supplier_company_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details, supplier_company_id_other, asset_details_other, asset_make_other, asset_model_other, asset_acquired_date_other, asset_disposed_date_other, other_asset_details_other FROM (SELECT LHS.asset_id AS asset_id, LHS.maintenance_contract_id AS maintenance_contract_id, LHS.supplier_company_id AS supplier_company_id, LHS.asset_details AS asset_details, LHS.asset_make AS asset_make, LHS.asset_model AS asset_model, LHS.asset_acquired_date AS asset_acquired_date, LHS.asset_disposed_date AS asset_disposed_date, LHS.other_asset_details AS other_asset_details, RHS.supplier_company_id AS supplier_company_id_other, RHS.asset_details AS asset_details_other, RHS.asset_make AS asset_make_other, RHS.asset_model AS asset_model_other, RHS.asset_acquired_date AS asset_acquired_date_other, RHS.asset_disposed_date AS asset_disposed_date_other, RHS.other_asset_details AS other_asset_details_other FROM assets AS LHS INNER JOIN assets AS RHS ON (LHS.maintenance_contract_id = RHS.asset_id AND LHS.supplier_company_id = RHS.maintenance_contract_id))) ORDER BY asset_acquired_date;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT asset_acquired_date FROM Assets ORDER BY asset_acquired_date ASC, Assets.asset_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/