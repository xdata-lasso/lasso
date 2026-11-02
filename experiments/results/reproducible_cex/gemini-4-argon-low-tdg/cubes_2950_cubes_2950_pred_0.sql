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
-- DATASET 3
-- Tests SELECT DISTINCT vs SELECT ALL (duplicate output rows when multiple parking fines exist for the same cross-ref or identical cross-ref attributes), and tests multi-level ORDER BY tie-breaking.
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (5, 'Cust 5');
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (6, 'Cust 6');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (50, 6, 'ALPHA');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (51, 5, 'ALPHA');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (52, 5, 'BETA');
INSERT INTO "Parking_Fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (9002, 50);
INSERT INTO "Parking_Fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (9001, 50);
INSERT INTO "Parking_Fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (8000, 51);
INSERT INTO "Parking_Fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (7000, 52);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source_system_code, master_customer_id, council_tax_id FROM (SELECT LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.master_customer_id AS master_customer_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM cmi_cross_references AS LHS INNER JOIN parking_fines AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY source_system_code, master_customer_id NULLS LAST, council_tax_id NULLS LAST;

/*
Gold Result:
('ALPHA', 5, 8000)
('ALPHA', 6, 9001)
('ALPHA', 6, 9002)
('BETA', 5, 7000)
*/

-- Prediction Query
SELECT T1.source_system_code, T1.master_customer_id, T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Parking_Fines AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id;

/*
Prediction Result:
('BETA', 5, 7000)
('ALPHA', 5, 8000)
('ALPHA', 6, 9001)
('ALPHA', 6, 9002)
*/