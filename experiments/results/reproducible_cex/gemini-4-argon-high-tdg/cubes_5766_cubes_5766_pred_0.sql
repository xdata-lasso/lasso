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
-- DATASET 2
INSERT INTO Third_Party_Companies (company_id, company_type, company_name, company_address, other_company_details) VALUES (1, 'MNT', 'Beta LLC', '200 Oak Ave', 'None');
INSERT INTO Maintenance_Contracts (maintenance_contract_id, maintenance_contract_company_id, contract_start_date, contract_end_date, other_contract_details) VALUES (1, 1, '2022-01-01 00:00:00', '2023-01-01 00:00:00', 'Premium');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (10, 1, 1, 'Printer', 'HP', 'LaserJet', '2022-03-01 00:00:00', '2024-03-01 00:00:00', 'Office');
INSERT INTO Assets (asset_id, supplier_company_id, maintenance_contract_id, asset_details, asset_make, asset_model, asset_acquired_date, asset_disposed_date, other_asset_details) VALUES (20, 1, 1, 'Scanner', 'Canon', 'DR-C225', '2022-04-01 00:00:00', '2024-04-01 00:00:00', 'Office');
INSERT INTO Parts (part_id, part_name, chargeable_yn, chargeable_amount, other_part_details) VALUES (30, 'A_Roller', 1, 15, 'Rubber');
INSERT INTO Parts (part_id, part_name, chargeable_yn, chargeable_amount, other_part_details) VALUES (20, 'M_Toner', 1, 80, 'Black');
INSERT INTO Parts (part_id, part_name, chargeable_yn, chargeable_amount, other_part_details) VALUES (10, 'Z_Belt', 0, 15, 'Synthetic');
INSERT INTO Parts (part_id, part_name, chargeable_yn, chargeable_amount, other_part_details) VALUES (5, 'B_Fuser', 0, 120, 'Heat unit');
INSERT INTO Asset_Parts (asset_id, part_id) VALUES (10, 30);
INSERT INTO Asset_Parts (asset_id, part_id) VALUES (20, 30);
INSERT INTO Asset_Parts (asset_id, part_id) VALUES (10, 10);
INSERT INTO Asset_Parts (asset_id, part_id) VALUES (20, 10);
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (1, 30, 'JAM', 'Paper jam', 'Minor');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (2, 30, 'WEAR', 'Worn roller', 'Minor');
INSERT INTO Part_Faults (part_fault_id, part_id, fault_short_name, fault_description, other_fault_details) VALUES (3, 10, 'SLIP', 'Belt slip', 'Moderate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT part_id, minchargeable_amount AS chargeable_amount FROM (SELECT LHS.part_id AS part_id, LHS.part_name AS part_name, LHS.chargeable_yn AS chargeable_yn, LHS.chargeable_amount AS chargeable_amount, LHS.other_part_details AS other_part_details, LHS.minchargeable_amount AS minchargeable_amount, RHS.part_name AS part_name_other, RHS.chargeable_yn AS chargeable_yn_other, RHS.other_part_details AS other_part_details_other FROM (SELECT part_id, part_name, chargeable_yn, chargeable_amount, other_part_details, MIN(chargeable_amount) OVER () AS minchargeable_amount FROM parts) AS LHS INNER JOIN parts AS RHS ON (LHS.part_id = RHS.part_id AND LHS.minchargeable_amount = RHS.chargeable_amount)) ORDER BY part_id;

/*
Gold Result:
(10, 15)
(30, 15)
*/

-- Prediction Query
SELECT part_id, chargeable_amount FROM Parts ORDER BY chargeable_amount ASC LIMIT 1;

/*
Prediction Result:
(10, 15)
*/