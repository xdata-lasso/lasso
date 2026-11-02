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
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (10, 'Supp', 'Apex Supply', '100 Main St', 'Tier 1');
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (20, 'Supp', 'Bolt Corp', '200 Oak Ave', 'Tier 2');
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (30, 'Both', 'Core Tech', '300 Pine Rd', 'Tier 1');
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (40, 'Maint', 'Delta Maint', '400 Elm St', 'No assets supplied');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (100, 40, '2023-01-01 00:00:00', '2024-01-01 00:00:00', 'Full coverage');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (200, 30, '2023-06-01 00:00:00', '2024-06-01 00:00:00', 'Partial coverage');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (1, 40, 'Alice', 'Smith', 'Senior');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (2, 40, 'Bob', 'Jones', 'Junior');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (1, 30, 100, 'Server A', 'Dell', 'R740', '2023-01-15 00:00:00', '2025-01-15 00:00:00', 'Rack 1');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (2, 20, 100, 'Router B1', 'Cisco', 'ISR4', '2023-02-10 00:00:00', '2025-02-10 00:00:00', 'Rack 2');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (3, 20, 200, 'Router B2', 'Cisco', 'ISR4', '2023-02-12 00:00:00', '2025-02-12 00:00:00', 'Rack 2');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (4, 10, 200, 'Switch C1', 'HP', 'ProCurve', '2023-03-01 00:00:00', '2025-03-01 00:00:00', 'Rack 3');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (5, 10, 200, 'Switch C2', 'HP', 'ProCurve', '2023-03-02 00:00:00', '2025-03-02 00:00:00', 'Rack 3');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (6, 10, 100, 'Switch C3', 'HP', 'ProCurve', '2023-03-03 00:00:00', '2025-03-03 00:00:00', 'Rack 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, supplier_company_id AS company_id FROM (SELECT LHS.company_id AS company_id, LHS.company_type AS company_type, LHS.company_name AS company_name, LHS.company_address AS company_address, LHS.other_company_details AS other_company_details, LHS.asset_id AS asset_id, LHS.maintenance_contract_id AS maintenance_contract_id, LHS.supplier_company_id AS supplier_company_id, LHS.asset_details AS asset_details, LHS.asset_make AS asset_make, LHS.asset_model AS asset_model, LHS.asset_acquired_date AS asset_acquired_date, LHS.asset_disposed_date AS asset_disposed_date, LHS.other_asset_details AS other_asset_details, RHS.n AS n FROM (SELECT LHS.company_id AS company_id, LHS.company_type AS company_type, LHS.company_name AS company_name, LHS.company_address AS company_address, LHS.other_company_details AS other_company_details, RHS.asset_id AS asset_id, RHS.maintenance_contract_id AS maintenance_contract_id, RHS.supplier_company_id AS supplier_company_id, RHS.asset_details AS asset_details, RHS.asset_make AS asset_make, RHS.asset_model AS asset_model, RHS.asset_acquired_date AS asset_acquired_date, RHS.asset_disposed_date AS asset_disposed_date, RHS.other_asset_details AS other_asset_details FROM third_party_companies AS LHS CROSS JOIN assets AS RHS) AS LHS INNER JOIN (SELECT supplier_company_id, COUNT(*) AS n FROM assets GROUP BY supplier_company_id) AS RHS ON (LHS.supplier_company_id = RHS.supplier_company_id)) ORDER BY count___;

/*
Gold Result:
(1, 30)
(2, 20)
(3, 10)
*/

-- Prediction Query
SELECT COUNT(*), T1.company_id FROM Third_Party_Companies AS T1 JOIN Assets AS T2 ON T1.company_id = T2.supplier_company_id GROUP BY T1.company_id;

/*
Prediction Result:
(3, 10)
(2, 20)
(1, 30)
*/