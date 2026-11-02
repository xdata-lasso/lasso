-- Schema DDL
CREATE TABLE "Customer_Master_Index" ("master_customer_id" INTEGER PRIMARY KEY, "cmi_details" TEXT(255));

CREATE TABLE "CMI_Cross_References" ("cmi_cross_ref_id" INTEGER PRIMARY KEY, "master_customer_id" INTEGER, "source_system_code" TEXT(15), FOREIGN KEY ("master_customer_id") REFERENCES "Customer_Master_Index" ("master_customer_id"));

CREATE TABLE "Council_Tax" ("council_tax_id" INTEGER PRIMARY KEY, "cmi_cross_ref_id" INTEGER, FOREIGN KEY ("cmi_cross_ref_id") REFERENCES "CMI_Cross_References" ("cmi_cross_ref_id"));

CREATE TABLE "Business_Rates" ("business_rates_id" INTEGER PRIMARY KEY, "cmi_cross_ref_id" INTEGER, FOREIGN KEY ("cmi_cross_ref_id") REFERENCES "CMI_Cross_References" ("cmi_cross_ref_id"));

CREATE TABLE "Benefits_Overpayments" ("council_tax_id" INTEGER PRIMARY KEY, "cmi_cross_ref_id" INTEGER, FOREIGN KEY ("cmi_cross_ref_id") REFERENCES "CMI_Cross_References" ("cmi_cross_ref_id"));

CREATE TABLE "Parking_Fines" ("council_tax_id" INTEGER PRIMARY KEY, "cmi_cross_ref_id" INTEGER, FOREIGN KEY ("cmi_cross_ref_id") REFERENCES "CMI_Cross_References" ("cmi_cross_ref_id"));

CREATE TABLE "Rent_Arrears" ("council_tax_id" INTEGER PRIMARY KEY, "cmi_cross_ref_id" INTEGER, FOREIGN KEY ("cmi_cross_ref_id") REFERENCES "CMI_Cross_References" ("cmi_cross_ref_id"));

CREATE TABLE "Electoral_Register" ("electoral_register_id" INTEGER PRIMARY KEY, "cmi_cross_ref_id" INTEGER, FOREIGN KEY ("cmi_cross_ref_id") REFERENCES "CMI_Cross_References" ("cmi_cross_ref_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Unordered insertion of master_customer_id (including negative, 0, and positive) to kill missing ORDER BY, ORDER BY DESC, or ORDER BY cmi_details.
-- 2. Customers with 0, 1, and multiple cross-references to kill mutants with extraneous INNER JOIN or un-grouped LEFT JOIN to CMI_Cross_References.
-- 3. Duplicate cmi_details to kill mutants that group by or select distinct cmi_details.
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (10, 'Zebra Corp');
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (-5, 'Zebra Corp');
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (2, 'Alpha Inc');
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (0, 'Beta LLC');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (100, 10, 'SYS_A');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (101, 10, 'SYS_B');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (102, 2, 'SYS_A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT master_customer_id, cmi_details FROM customer_master_index ORDER BY master_customer_id;

/*
Gold Result:
(-5, 'Zebra Corp')
(0, 'Beta LLC')
(2, 'Alpha Inc')
(10, 'Zebra Corp')
*/

-- Prediction Query
SELECT * FROM customer_master_index ORDER BY cmi_details DESC, customer_master_index.master_customer_id NULLS LAST;

/*
Prediction Result:
(-5, 'Zebra Corp')
(10, 'Zebra Corp')
(0, 'Beta LLC')
(2, 'Alpha Inc')
*/