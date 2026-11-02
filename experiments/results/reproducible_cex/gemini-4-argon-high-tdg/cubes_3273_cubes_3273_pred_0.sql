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
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (10, 'SUPP', 'Alpha Corp', '100 Main St', 'Primary');
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (20, 'MAINT', 'Beta LLC', '200 Oak Ave', 'Secondary');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (100, 20, '2022-01-01 00:00:00', '2023-01-01 00:00:00', 'Premium');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (200, 10, '2022-02-01 00:00:00', '2023-02-01 00:00:00', 'SameDetails');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (300, 10, '2022-03-01 00:00:00', '2023-03-01 00:00:00', 'SameDetails');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (400, 20, '2022-04-01 00:00:00', '2023-04-01 00:00:00', 'UnusedContract');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (1, 10, 200, 'Server A', 'Dell', 'R740', '2022-02-10 00:00:00', NULL, 'Rack 1');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (2, 20, 200, 'Server B', 'HP', 'DL380', '2022-02-15 00:00:00', '2023-01-10 00:00:00', 'Rack 2');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (3, 10, 100, 'Router 1', 'Cisco', 'ISR4000', '2022-01-05 00:00:00', NULL, 'Core');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (4, 10, 100, 'Router 1', 'Cisco', 'ISR4000', '2022-01-05 00:00:00', NULL, 'Core');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (5, 10, 100, 'Router 1', 'Cisco', 'ISR4000', '2022-01-05 00:00:00', NULL, 'Core');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (6, NULL, 300, 'Printer', 'Brother', 'HL-L', '2022-03-10 00:00:00', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, maintenance_contract_id FROM (SELECT maintenance_contract_id, other_contract_details, COUNT(*) AS n FROM (SELECT LHS.asset_id AS asset_id, LHS.maintenance_contract_id AS maintenance_contract_id, LHS.supplier_company_id AS supplier_company_id, LHS.asset_details AS asset_details, LHS.asset_make AS asset_make, LHS.asset_model AS asset_model, LHS.asset_acquired_date AS asset_acquired_date, LHS.asset_disposed_date AS asset_disposed_date, LHS.other_asset_details AS other_asset_details, RHS.maintenance_contract_company_id AS maintenance_contract_company_id, RHS.contract_start_date AS contract_start_date, RHS.contract_end_date AS contract_end_date, RHS.other_contract_details AS other_contract_details FROM assets AS LHS LEFT JOIN maintenance_contracts AS RHS ON (LHS.maintenance_contract_id = RHS.maintenance_contract_id)) GROUP BY maintenance_contract_id, other_contract_details) ORDER BY count___;

/*
Gold Result:
(1, 300)
(2, 200)
(3, 100)
*/

-- Prediction Query
SELECT COUNT(*), T1.maintenance_contract_id FROM Maintenance_Contracts AS T1 JOIN Assets AS T2 ON T1.maintenance_contract_id = T2.maintenance_contract_id GROUP BY T1.maintenance_contract_id;

/*
Prediction Result:
(3, 100)
(2, 200)
(1, 300)
*/