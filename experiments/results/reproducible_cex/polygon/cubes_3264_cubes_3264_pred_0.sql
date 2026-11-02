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
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (18, '30', '30', '30', '30');
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (17, '30', '30', '30', '30');
INSERT INTO "Maintenance_Contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (20, 17, 30, 30, '30');
INSERT INTO "Maintenance_Contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (19, 17, 30, 30, '30');
INSERT INTO "Skills" ("skill_id", "skill_code", "skill_description") VALUES (21, '30', '30');
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (22, 17, 19, '30', '30', '30', 30, 30, '30');
INSERT INTO "Asset_Parts" ("asset_id", "part_id") VALUES (22, 23);
INSERT INTO "Maintenance_Engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (26, 17, '30', '30', '30');
INSERT INTO "Maintenance_Engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (25, 17, '30', '30', '30');
INSERT INTO "Part_Faults" ("part_fault_id", "part_id", "fault_short_name", "fault_description", "other_fault_details") VALUES (29, 24, '30', '30', '30');
INSERT INTO "Skills_Required_To_Fix" ("skill_id", "part_fault_id") VALUES (21, 29);
INSERT INTO "Skills_Required_To_Fix" ("skill_id", "part_fault_id") VALUES (21, 29);
INSERT INTO "Staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (27, '30', 30, '30');
INSERT INTO "Staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (28, '30', 30, '30');
INSERT INTO "Parts" ("part_id", "part_name", "chargeable_yn", "chargeable_amount", "other_part_details") VALUES (23, '30', 30, 30, '30');
INSERT INTO "Parts" ("part_id", "part_name", "chargeable_yn", "chargeable_amount", "other_part_details") VALUES (24, '30', 30, 30, '30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM maintenance_engineers ORDER BY last_name, maintenance_engineers.engineer_id NULLS LAST;

/*
Gold Result:
('30',)
('30',)
*/

-- Prediction Query
SELECT DISTINCT last_name FROM Maintenance_Engineers;

/*
Prediction Result:
('30',)
*/