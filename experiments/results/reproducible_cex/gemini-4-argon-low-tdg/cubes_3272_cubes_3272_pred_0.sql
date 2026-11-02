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
-- Tests the composite INNER JOIN condition (LHS.fault_log_entry_id = RHS.fault_log_entry_id AND LHS.part_fault_id = RHS.recorded_by_staff_id),
-- distinguishing full matches from partial matches on either column, and verifying that Part_Faults.fault_description is not confused with Fault_Log.fault_description.
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (1, 'SUP', 'TechCorp', '123 Tech St', 'None');
INSERT INTO "Maintenance_Contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (1, 1, '2023-01-01 00:00:00', '2024-01-01 00:00:00', 'Standard');
INSERT INTO "Assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (1, 1, 1, 'Main Server', 'Dell', 'PowerEdge', '2022-01-01 00:00:00', '2025-01-01 00:00:00', 'None');
INSERT INTO "Staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (10, 'Alice', 1, 'Admin');
INSERT INTO "Staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (20, 'Bob', 0, 'Tech');
INSERT INTO "Parts" ("part_id", "part_name", "chargeable_yn", "chargeable_amount", "other_part_details") VALUES (1, 'Power Supply', 1, 100, 'None');
INSERT INTO "Part_Faults" ("part_fault_id", "part_id", "fault_short_name", "fault_description", "other_fault_details") VALUES (10, 1, 'PSU_FAIL', 'Part Fault Desc 10', 'None');
INSERT INTO "Part_Faults" ("part_fault_id", "part_id", "fault_short_name", "fault_description", "other_fault_details") VALUES (20, 1, 'PSU_SURGE', 'Part Fault Desc 20', 'None');
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (100, 10, 1, '2023-05-01 10:00:00', 'Log Fault Alpha', 'Details A');
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (200, 20, 1, '2023-05-02 11:00:00', 'Log Fault Beta', 'Details B');
INSERT INTO "Fault_Log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (300, 10, 1, '2023-05-03 12:00:00', 'Log Fault Gamma', 'Details C');
-- Matches both fault_log_entry_id (100) and part_fault_id = recorded_by_staff_id (10)
INSERT INTO "Fault_Log_Parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (100, 10, 'Open');
-- Matches fault_log_entry_id (100), but part_fault_id (20) != recorded_by_staff_id (10)
INSERT INTO "Fault_Log_Parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (100, 20, 'Closed');
-- Matches part_fault_id = recorded_by_staff_id (20) for entry 200, and also tests multiple matching rows in Fault_Log_Parts for the same Fault_Log
INSERT INTO "Fault_Log_Parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (200, 20, 'Open');
INSERT INTO "Fault_Log_Parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (200, 20, 'Pending');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS fault_log_entry_id, fault_description, fault_log_entry_datetime FROM (SELECT fault_description, fault_log_entry_datetime, COUNT(*) AS n FROM (SELECT fault_log_entry_id, part_fault_id, fault_status, asset_id, fault_log_entry_datetime, fault_description, other_fault_details, part_fault_id AS recorded_by_staff_id FROM (SELECT LHS.fault_log_entry_id AS fault_log_entry_id, LHS.part_fault_id AS part_fault_id, LHS.fault_status AS fault_status, RHS.asset_id AS asset_id, RHS.fault_log_entry_datetime AS fault_log_entry_datetime, RHS.fault_description AS fault_description, RHS.other_fault_details AS other_fault_details FROM fault_log_parts AS LHS INNER JOIN fault_log AS RHS ON (LHS.fault_log_entry_id = RHS.fault_log_entry_id AND LHS.part_fault_id = RHS.recorded_by_staff_id))) GROUP BY fault_description, fault_log_entry_datetime) ORDER BY fault_log_entry_id;

/*
Gold Result:
(1, 'Log Fault Alpha', '2023-05-01 10:00:00')
(2, 'Log Fault Beta', '2023-05-02 11:00:00')
*/

-- Prediction Query
SELECT T1.fault_log_entry_id, T1.fault_description, T1.fault_log_entry_datetime FROM Fault_Log AS T1 JOIN Fault_Log_Parts AS T2 ON T1.fault_log_entry_id = T2.fault_log_entry_id GROUP BY T1.fault_log_entry_id ORDER BY COUNT(*) DESC LIMIT 1;

/*
Prediction Result:
(200, 'Log Fault Beta', '2023-05-02 11:00:00')
*/