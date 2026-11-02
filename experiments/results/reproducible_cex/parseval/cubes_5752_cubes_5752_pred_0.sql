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
-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483648, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483647, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483646, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (2, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (3, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483645, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483642, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483641, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483640, 'sta_382df7', 3, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483639, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483638, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483637, 'sta_382df7', 3, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483636, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483635, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483634, 'sta_382df7', 3, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483633, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483632, 'sta_382df7', 2, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483631, 'sta_382df7', 3, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483630, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483629, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483628, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483627, 'sta_382df7', NULL, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483626, 'sta_382df7', NULL, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (-2147483625, 'sta_382df7', NULL, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (5, 'sta_382df7', 1, 'sta_f4f259');

INSERT INTO "staff" ("staff_id", "staff_name", "gender", "other_staff_details") VALUES (4, 'sta_382df7', 1, 'sta_f4f259');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gender FROM (SELECT * FROM (SELECT * FROM (SELECT staff_id, staff_name, gender, other_staff_details, n, MAX(n) OVER () AS maxn FROM (SELECT staff_id, staff_name, gender, other_staff_details, COUNT(*) OVER () AS n FROM staff)) ORDER BY gender DESC) LIMIT 1);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT gender FROM staff GROUP BY gender ORDER BY COUNT(*) DESC LIMIT 1;

/*
Prediction Result:
(1,)
*/