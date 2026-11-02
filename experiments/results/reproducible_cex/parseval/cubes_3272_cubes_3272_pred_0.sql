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
-- Inserting into table: third_party_companies --
INSERT INTO "third_party_companies" ("company_id", "company_type", "company_name", "company_address", "other_company_details") VALUES (-2147483648, '29001', 'thi_a15002', 'thi_8754eb', 'thi_e560f2');

-- Inserting into table: assets --
INSERT INTO "assets" ("asset_id", "supplier_company_id", "maintenance_contract_id", "asset_details", "asset_make", "asset_model", "asset_acquired_date", "asset_disposed_date", "other_asset_details") VALUES (1, -2147483648, -2147483648, 'ass_51c578', 'ass_1a665d', 'ass_cf9ed0', '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 'ass_2ab221');

-- Inserting into table: fault_log --
INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (1, -2147483648, 1, '2024-06-15 00:00:00+00:00', 'rhs_927712', 'rhs_6e0fde');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (-2147483647, -2147483648, 1, '2024-06-15 00:00:00+00:00', 'rhs_2acf43', 'rhs_356b8a');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (2, -2147483648, 1, '2023-05-25 17:04:36+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (3, -2147483648, 1, '2022-12-20 09:53:17+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (4, -2147483648, 1, '2024-04-12 00:38:47+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (5, -2147483648, 1, '2022-11-06 10:19:41+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (6, -2147483648, 1, '2022-08-02 13:58:36+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (7, -2147483648, 1, '2025-02-07 06:53:31+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (8, -2147483648, 1, '2021-08-20 16:50:24+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (9, -2147483648, 1, '2025-04-09 18:22:58+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (10, -2147483648, 1, '2020-08-22 06:30:10+00:00', 'fau_f9eb6c', 'fau_e0336b');

INSERT INTO "fault_log" ("fault_log_entry_id", "recorded_by_staff_id", "asset_id", "fault_log_entry_datetime", "fault_description", "other_fault_details") VALUES (11, -2147483648, 1, '2022-12-10 02:38:39+00:00', 'fau_f9eb6c', 'fau_e0336b');

-- Inserting into table: part_faults --
INSERT INTO "part_faults" ("part_fault_id", "part_id", "fault_short_name", "fault_description", "other_fault_details") VALUES (1, -2147483648, 'par_7e0350', 'par_004a4b', 'par_6f8313');

-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483648, 'sta_382df7', -55602865, 'sta_f4f259');

-- Inserting into table: parts --
INSERT INTO "parts" ("part_id", "part_name", "chargeable_yn", "chargeable_amount", "other_part_details") VALUES (-2147483648, 'par_01383d', -1981402255, -890215420, 'par_8c8096');

-- Inserting into table: maintenance_contracts --
INSERT INTO "maintenance_contracts" ("maintenance_contract_id", "maintenance_contract_company_id", "contract_start_date", "contract_end_date", "other_contract_details") VALUES (-2147483648, -2147483648, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00', 'mai_b1ea88');

-- Inserting into table: fault_log_parts --
INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_c6bb12');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'lhs_28f282');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (2, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (3, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (4, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (5, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (6, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (-2147483647, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (-2147483647, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (1, 1, 'fau_3edd5f');

INSERT INTO "fault_log_parts" ("fault_log_entry_id", "part_fault_id", "fault_status") VALUES (2, 1, 'fau_3edd5f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS fault_log_entry_id, fault_description, fault_log_entry_datetime FROM (SELECT fault_description, fault_log_entry_datetime, COUNT(*) AS n FROM (SELECT fault_log_entry_id, part_fault_id, fault_status, asset_id, fault_log_entry_datetime, fault_description, other_fault_details, part_fault_id AS recorded_by_staff_id FROM (SELECT LHS.fault_log_entry_id AS fault_log_entry_id, LHS.part_fault_id AS part_fault_id, LHS.fault_status AS fault_status, RHS.asset_id AS asset_id, RHS.fault_log_entry_datetime AS fault_log_entry_datetime, RHS.fault_description AS fault_description, RHS.other_fault_details AS other_fault_details FROM fault_log_parts AS LHS INNER JOIN fault_log AS RHS ON (LHS.fault_log_entry_id = RHS.fault_log_entry_id AND LHS.part_fault_id = RHS.recorded_by_staff_id))) GROUP BY fault_description, fault_log_entry_datetime) ORDER BY fault_log_entry_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.fault_log_entry_id, T1.fault_description, T1.fault_log_entry_datetime FROM Fault_Log AS T1 JOIN Fault_Log_Parts AS T2 ON T1.fault_log_entry_id = T2.fault_log_entry_id GROUP BY T1.fault_log_entry_id ORDER BY COUNT(*) DESC LIMIT 1;

/*
Prediction Result:
(1, 'rhs_927712', '2024-06-15 00:00:00+00:00')
*/