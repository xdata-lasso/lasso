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
-- DATASET 1
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name") VALUES (1, 'SUP', 'Acme Corp');
INSERT INTO "Maintenance_Contracts" ("maintenance_contract_id", "maintenance_contract_company_id") VALUES (1, 1);
INSERT INTO "Staff" ("staff_id", "staff_name", "gender") VALUES (1, 'Alice', 1);
-- Asset 1: Model 'Model_Alpha' has NO faults, and duplicate model name 'Model_Alpha' on Asset 2 ALSO has NO faults (tests DISTINCT vs ALL)
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_make", "asset_model") VALUES (1, 1, 1, 'Make_Z', 'Model_Alpha');
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_make", "asset_model") VALUES (2, 1, 1, 'Make_A', 'Model_Alpha');
-- Asset 3 & 4: Both have model 'Model_Shared'. Asset 3 has NO faults, Asset 4 HAS a fault (tests EXCEPT on asset_model vs anti-join on asset_id)
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_make", "asset_model") VALUES (3, 1, 1, 'Make_M', 'Model_Shared');
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_make", "asset_model") VALUES (4, 1, 1, 'Make_B', 'Model_Shared');
-- Asset 5: Has multiple faults (tests EXISTS vs NOT EXISTS, and JOIN multiplicity)
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_make", "asset_model") VALUES (5, 1, 1, 'Make_C', 'Model_Faulty');
-- Asset 6: Unfaulted asset inserted out of alphabetical order to test ORDER BY asset_model ASC vs DESC / insertion order / asset_id order
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_make", "asset_model") VALUES (6, 1, 1, 'Make_D', 'Model_001');
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_description") VALUES (10, 1, 4, 'Minor scratch');
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_description") VALUES (11, 1, 5, 'Broken screen');
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_description") VALUES (12, 1, 5, 'Power failure');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT asset_model FROM (SELECT * FROM assets AS LHS WHERE NOT EXISTS(SELECT 1 FROM fault_log AS RHS WHERE (LHS.asset_id = RHS.asset_id))) ORDER BY asset_model;

/*
Gold Result:
('Model_001',)
('Model_Alpha',)
('Model_Alpha',)
('Model_Shared',)
*/

-- Prediction Query
SELECT asset_model FROM Assets WHERE NOT asset_id IN (SELECT asset_id FROM Fault_Log);

/*
Prediction Result:
('Model_Alpha',)
('Model_Alpha',)
('Model_Shared',)
('Model_001',)
*/