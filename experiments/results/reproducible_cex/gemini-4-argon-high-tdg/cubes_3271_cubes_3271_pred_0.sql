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
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (1, 'C_ONE', 'Z_Desc_1');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (2, 'B_TWO', 'M_Desc_2');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (3, 'A_THREE', 'A_Desc_3');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (10, 'D_TEN', 'Desc_10');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (20, 'E_TWENTY', 'Desc_20');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (30, 'F_THIRTY', 'Desc_30');
INSERT INTO Skills (skill_id, skill_code, skill_description) VALUES (40, 'G_FORTY', 'Desc_40');
INSERT INTO Parts (part_id, part_name, chargeable_yn, chargeable_amount, other_part_details) VALUES (100, 'Motor', 1, 500, 'Main');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (101, 100, 'F1', 'Fault 1', 'D1');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (102, 100, 'F2', 'Fault 2', 'D2');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (103, 100, 'F3', 'Fault 3', 'D3');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (104, 100, 'F4', 'Fault 4', 'D4');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (105, 100, 'F5', 'Fault 5', 'D5');
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (10, 101);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (10, 102);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (10, 103);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (20, 101);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (30, 101);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (30, 102);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (40, 101);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (40, 102);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (40, 103);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (40, 104);
INSERT INTO Skills_Required_To_Fix (skill_id, part_fault_id) VALUES (40, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT skill_id, skill_description FROM (SELECT LHS.skill_id AS skill_id, LHS.skill_code AS skill_code, LHS.skill_description AS skill_description, RHS.skill_id AS skill_id_other FROM skills AS LHS INNER JOIN (SELECT skill_id, COUNT(*) AS n FROM skills_required_to_fix GROUP BY skill_id) AS RHS ON (LHS.skill_id = RHS.n)) ORDER BY skill_id;

/*
Gold Result:
(1, 'Z_Desc_1')
(2, 'M_Desc_2')
(3, 'A_Desc_3')
*/

-- Prediction Query
SELECT T1.skill_id, T1.skill_description FROM Skills AS T1 JOIN Skills_Required_To_Fix AS T2 ON T1.skill_id = T2.skill_id GROUP BY T1.skill_id ORDER BY COUNT(*) DESC LIMIT 1;

/*
Prediction Result:
(40, 'Desc_40')
*/