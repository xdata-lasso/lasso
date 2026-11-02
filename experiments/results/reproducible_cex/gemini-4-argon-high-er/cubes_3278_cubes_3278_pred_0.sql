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
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (1, 'Supp', 'Acme Corp', '123 Main St', 'None');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (1, 1, '2023-01-01 00:00:00', '2024-01-01 00:00:00', 'Standard');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (1, 1, 1, 'Printer', 'HP', 'LaserJet', '2023-01-01 00:00:00', '2025-01-01 00:00:00', 'None');
INSERT INTO Staff (staff_id, staff_name, gender, other_staff_details) VALUES (1, 'Alice', 1, 'Tech');
INSERT INTO Parts (part_id, part_name, chargeable_yn, chargeable_amount, other_part_details) VALUES (1, 'Roller', 0, 0, 'None');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (1, 1, 'Jam', 'Paper jam', 'None');
INSERT INTO Fault_Log (fault_log_entry_id, recorded_by_staff_id, asset_id, fault_log_entry_datetime, fault_description, other_fault_details) VALUES (1, 1, 1, '2023-06-01 10:00:00', 'B_Fault', 'None');
INSERT INTO Fault_Log (fault_log_entry_id, recorded_by_staff_id, asset_id, fault_log_entry_datetime, fault_description, other_fault_details) VALUES (2, 1, 1, '2023-06-02 10:00:00', 'A_Fault', 'None');
INSERT INTO Fault_Log_Parts (fault_log_entry_id, part_fault_id, fault_status) VALUES (1, 1, 'Open');
INSERT INTO Fault_Log_Parts (fault_log_entry_id, part_fault_id, fault_status) VALUES (2, 1, 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fault_description, fault_status FROM (SELECT LHS.fault_log_entry_id AS fault_log_entry_id, LHS.asset_id AS asset_id, LHS.recorded_by_staff_id AS recorded_by_staff_id, LHS.fault_log_entry_datetime AS fault_log_entry_datetime, LHS.fault_description AS fault_description, LHS.other_fault_details AS other_fault_details, RHS.part_fault_id AS part_fault_id, RHS.fault_status AS fault_status FROM fault_log AS LHS INNER JOIN fault_log_parts AS RHS ON (LHS.fault_log_entry_id = RHS.fault_log_entry_id)) ORDER BY fault_description;

/*
Gold Result:
('A_Fault', 'Closed')
('B_Fault', 'Open')
*/

-- Prediction Query
SELECT T1.fault_description, T2.fault_status FROM Fault_Log AS T1 JOIN Fault_Log_Parts AS T2 ON T1.fault_log_entry_id = T2.fault_log_entry_id;

/*
Prediction Result:
('B_Fault', 'Open')
('A_Fault', 'Closed')
*/