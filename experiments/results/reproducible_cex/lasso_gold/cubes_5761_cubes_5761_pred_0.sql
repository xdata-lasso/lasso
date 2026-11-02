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
INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (1007, 'Stacey Ward', 1008, 'dark');
INSERT INTO "third_party_companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (1009, 'Jones, Stanley and Mejia', 'Wyatt Inc', '525 Clark Grove Apt. 928
East Steven, KY 84387', 'Hawkins, Cohen and Cameron');
INSERT INTO "third_party_companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (1015, 'Jones, Stanley and Mejia', 'Wyatt Inc', '525 Clark Grove Apt. 928
East Steven, KY 84387', 'Hawkins, Cohen and Cameron');
INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (1010, 1009, '1977-08-08', '1978-09-09', 'stand');
INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (1016, 1015, '1977-08-08', '1978-09-09', 'stand');
INSERT INTO "maintenance_engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (1013, 1009, 'Brian', 'Underwood', 'support');
INSERT INTO "maintenance_engineers" ("engineer_id", "company_id", "first_name", "last_name", "other_details") VALUES (1014, 1009, 'Brian', 'Underwood', 'support');
INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (1011, 1009, 1010, 'four', 'institution', 'executive', '1979-10-10', '1980-11-11', 'attorney');
INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (1017, 1015, 1016, 'four', 'institution', 'executive', '1979-10-10', '1980-11-11', 'attorney');
INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (1012, 1007, 1011, '1981-01-12', 'Tree note responsibility defense material.', 'usually');
INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (1018, 1007, 1017, '1981-01-12', 'Tree note responsibility defense material.', 'usually');
INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (1009, 1007, 1013, 1012, 'who', '1982-02-13', '1983-03-14', 'question');
INSERT INTO "engineer_visits" ("engineer_visit_id", "contact_staff_id", "engineer_id", "fault_log_entry_id", "fault_status", "visit_start_datetime", "visit_end_datetime", "other_visit_details") VALUES (1015, 1007, 1014, 1012, 'who', '1982-02-13', '1983-03-14', 'question');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minn AS engineer_id, first_name, last_name FROM (SELECT first_name, last_name, MIN(n) AS minn FROM (SELECT engineer_id, company_id, first_name, last_name, other_details, n, company_id AS engineer_visit_id FROM (SELECT engineer_id, company_id, first_name, last_name, other_details, engineer_id AS n FROM (SELECT LHS.engineer_id AS engineer_id, LHS.company_id AS company_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.other_details AS other_details FROM maintenance_engineers AS LHS INNER JOIN (SELECT engineer_visit_id, COUNT(*) AS n FROM engineer_visits GROUP BY engineer_visit_id) AS RHS ON (LHS.engineer_id = RHS.n AND LHS.company_id = RHS.engineer_visit_id)))) GROUP BY first_name, last_name) ORDER BY engineer_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.engineer_id, T1.first_name, T1.last_name FROM Maintenance_Engineers AS T1 JOIN Engineer_Visits AS T2 ON T1.engineer_id = T2.engineer_id GROUP BY T1.engineer_id ORDER BY COUNT(*) ASC LIMIT 1;

/*
Prediction Result:
(1013, 'Brian', 'Underwood')
*/