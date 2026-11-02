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
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (1, 'Cust 1');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (2, 'Cust 2');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (10, 1, 'SYS_B');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (20, 1, NULL);
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (30, 2, 'SYS_A');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (40, NULL, 'SYS_C');
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (101, 20);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (102, 10);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (103, 10);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (104, NULL);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (105, 40);
INSERT INTO Business_Rates (business_rates_id, cmi_cross_ref_id) VALUES (201, 30);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (301, 30);
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (401, 30);
INSERT INTO Rent_Arrears (council_tax_id, cmi_cross_ref_id) VALUES (501, 30);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (601, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cmi_cross_ref_id, source_system_code FROM (SELECT LHS.council_tax_id AS council_tax_id, LHS.cmi_cross_ref_id AS cmi_cross_ref_id, RHS.master_customer_id AS master_customer_id, RHS.source_system_code AS source_system_code, RHS.n AS n FROM council_tax AS LHS LEFT JOIN (SELECT cmi_cross_ref_id, master_customer_id, source_system_code, COUNT(*) OVER () AS n FROM cmi_cross_references) AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) WHERE (n >= 1) ORDER BY cmi_cross_ref_id, source_system_code NULLS LAST;

/*
Gold Result:
(10, 'SYS_B')
(10, 'SYS_B')
(20, None)
(40, 'SYS_C')
*/

-- Prediction Query
SELECT T1.cmi_cross_ref_id, T1.source_system_code FROM CMI_Cross_References AS T1 JOIN Council_Tax AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id GROUP BY T1.cmi_cross_ref_id HAVING COUNT(*) >= 1;

/*
Prediction Result:
(10, 'SYS_B')
(20, None)
(40, 'SYS_C')
*/