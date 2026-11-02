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
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (1, 'SUP', 'TechCorp', '123 Main St', 'None');
INSERT INTO "Third_Party_Companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (2, 'MNT', 'FixItInc', '456 Oak Ave', 'None');
INSERT INTO "Skills" ("skill_id", "skill_code", "skill_description") VALUES (1, 'ELEC', 'Electrical Repair');
INSERT INTO "Skills" ("skill_id", "skill_code", "skill_description") VALUES (2, 'PLMB', 'Plumbing Repair');
INSERT INTO "Skills" ("skill_id", "skill_code", "skill_description") VALUES (3, 'HVAC', 'Heating and Cooling');
INSERT INTO "Maintenance_Engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (1, 1, 'Zack', 'Smith', 'Senior');
INSERT INTO "Maintenance_Engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (2, 2, 'Alice', 'Jones', 'Junior');
INSERT INTO "Maintenance_Engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (3, 1, 'Bob', 'Brown', 'Contractor');
INSERT INTO "Engineer_Skills" ("skill_id", "engineer_id") VALUES (1, 1);
INSERT INTO "Engineer_Skills" ("skill_id", "engineer_id") VALUES (2, 1);
INSERT INTO "Engineer_Skills" ("skill_id", "engineer_id") VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name, other_details, skill_description FROM (SELECT LHS.skill_id AS skill_id, LHS.skill_code AS skill_code, LHS.skill_description AS skill_description, LHS.engineer_id AS engineer_id, LHS.company_id AS company_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.other_details AS other_details FROM (SELECT LHS.skill_id AS skill_id, LHS.skill_code AS skill_code, LHS.skill_description AS skill_description, RHS.engineer_id AS engineer_id, RHS.company_id AS company_id, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.other_details AS other_details FROM skills AS LHS CROSS JOIN maintenance_engineers AS RHS) AS LHS INNER JOIN engineer_skills AS RHS ON (LHS.skill_id = RHS.skill_id AND LHS.engineer_id = RHS.engineer_id)) ORDER BY first_name;

/*
Gold Result:
('Alice', 'Jones', 'Junior', 'Electrical Repair')
('Zack', 'Smith', 'Senior', 'Electrical Repair')
('Zack', 'Smith', 'Senior', 'Plumbing Repair')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T1.other_details, T3.skill_description FROM Maintenance_Engineers AS T1 JOIN Engineer_Skills AS T2 ON T1.engineer_id = T2.engineer_id JOIN Skills AS T3 ON T2.skill_id = T3.skill_id;

/*
Prediction Result:
('Zack', 'Smith', 'Senior', 'Electrical Repair')
('Zack', 'Smith', 'Senior', 'Plumbing Repair')
('Alice', 'Jones', 'Junior', 'Electrical Repair')
*/