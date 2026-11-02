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
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (10, 'Maint', 'Alpha Corp', '100 Main St', 'Primary');
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (20, 'Supp', 'Beta LLC', '200 Oak Ave', 'Secondary');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (100, 10, '2023-01-01 00:00:00', '2023-12-31 23:59:59', 'Annual');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (100, 10, 100, 'Server Rack', 'Dell', 'R740', '2023-01-15 00:00:00', NULL, 'Active');
INSERT INTO Staff (staff_id, staff_name, gender, other_staff_details) VALUES (1, 'Sarah Connor', 0, 'Manager');
INSERT INTO Staff (staff_id, staff_name, gender, other_staff_details) VALUES (2, 'Kyle Reese', 1, 'Technician');
INSERT INTO Fault_Log (fault_log_entry_id, recorded_by_staff_id, asset_id, fault_log_entry_datetime, fault_description, other_fault_details) VALUES (1, 1, 100, '2023-05-01 10:00:00', 'Overheating', 'Urgent');
INSERT INTO Fault_Log (fault_log_entry_id, recorded_by_staff_id, asset_id, fault_log_entry_datetime, fault_description, other_fault_details) VALUES (3, 2, 100, '2023-05-02 11:00:00', 'Fan failure', 'Routine');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (1, 10, 'Charlie', 'Adams', 'Senior');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (2, 20, 'Alice', 'Zimmerman', 'Junior');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (3, 10, 'Bob', 'Baker', 'Mid');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (10, 20, 'David', 'Clark', 'Contractor');
INSERT INTO Maintenance_Engineers (engineer_id, company_id, first_name, last_name, other_details) VALUES (20, 20, 'Eve', 'Davis', 'Specialist');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (1, 'ELEC', 'Electrical');
INSERT INTO Engineer_Skills (skill_id, engineer_id) VALUES (1, 1);
INSERT INTO Engineer_Skills (skill_id, engineer_id) VALUES (1, 2);
INSERT INTO Engineer_Skills (skill_id, engineer_id) VALUES (1, 3);
INSERT INTO Engineer_Visits (engineer_visit_id, contact_staff_id, engineer_id, fault_log_entry_id, fault_status, visit_start_datetime, visit_end_datetime, other_visit_details) VALUES (1, 1, 10, 1, 'Fixed', '2023-05-01 12:00:00', '2023-05-01 14:00:00', 'Done');
INSERT INTO Engineer_Visits (engineer_visit_id, contact_staff_id, engineer_id, fault_log_entry_id, fault_status, visit_start_datetime, visit_end_datetime, other_visit_details) VALUES (2, 2, 20, 3, 'Pending', '2023-05-02 13:00:00', '2023-05-02 15:00:00', 'Part needed');
INSERT INTO Engineer_Visits (engineer_visit_id, contact_staff_id, engineer_id, fault_log_entry_id, fault_status, visit_start_datetime, visit_end_datetime, other_visit_details) VALUES (3, 1, 20, 1, 'Fixed', '2023-05-03 09:00:00', '2023-05-03 10:00:00', 'Follow-up');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT * FROM maintenance_engineers AS LHS WHERE NOT EXISTS(SELECT 1 FROM engineer_visits AS RHS WHERE (LHS.engineer_id = RHS.engineer_id))) ORDER BY first_name;

/*
Gold Result:
('Alice', 'Zimmerman')
('Bob', 'Baker')
('Charlie', 'Adams')
*/

-- Prediction Query
SELECT first_name, last_name FROM Maintenance_Engineers WHERE NOT engineer_id IN (SELECT engineer_id FROM Engineer_Visits);

/*
Prediction Result:
('Charlie', 'Adams')
('Alice', 'Zimmerman')
('Bob', 'Baker')
*/