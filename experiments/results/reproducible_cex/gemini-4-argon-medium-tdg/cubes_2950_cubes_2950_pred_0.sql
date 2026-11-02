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
-- Tests basic join, wrong table confusion (Council_Tax, Benefits_Overpayments, Rent_Arrears have identical columns to Parking_Fines), and wrong join key mutations (joining on master_customer_id or council_tax_id instead of cmi_cross_ref_id).
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (1, 'Cust 1');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (2, 'Cust 2');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (3, 'Cust 3');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (10, 1, 'SYS_A');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (20, 2, 'SYS_B');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (30, 3, 'SYS_C');
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (100, 10);
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (20, 30);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (200, 20);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (300, 20);
INSERT INTO Rent_Arrears (council_tax_id, cmi_cross_ref_id) VALUES (400, 20);
INSERT INTO Business_Rates (business_rates_id, cmi_cross_ref_id) VALUES (500, 20);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (600, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source_system_code, master_customer_id, council_tax_id FROM (SELECT LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.master_customer_id AS master_customer_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM cmi_cross_references AS LHS INNER JOIN parking_fines AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY source_system_code, master_customer_id NULLS LAST, council_tax_id NULLS LAST;

/*
Gold Result:
('SYS_A', 1, 100)
('SYS_C', 3, 20)
*/

-- Prediction Query
SELECT T1.source_system_code, T1.master_customer_id, T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Parking_Fines AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id;

/*
Prediction Result:
('SYS_C', 3, 20)
('SYS_A', 1, 100)
*/