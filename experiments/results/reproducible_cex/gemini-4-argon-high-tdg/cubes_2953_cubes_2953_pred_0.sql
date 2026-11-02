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
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (10, 'Details_10');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (20, 'Details_20');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (100, 'Details_100');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (200, 'Details_200');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (10, 200, 'Z_SYS');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (20, 100, 'A_SYS');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (30, 10, 'M_SYS_UNREF');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (40, 20, 'B_SYS_UNREF');
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (1, 20);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (30, 10);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (40, 10);
INSERT INTO Business_Rates (business_rates_id, cmi_cross_ref_id) VALUES (1, 30);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (1, 30);
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (1, 40);
INSERT INTO Rent_Arrears (council_tax_id, cmi_cross_ref_id) VALUES (1, 30);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (1, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cmi_cross_ref_id, source_system_code FROM (SELECT LHS.council_tax_id AS council_tax_id, LHS.cmi_cross_ref_id AS cmi_cross_ref_id, RHS.master_customer_id AS master_customer_id, RHS.source_system_code AS source_system_code, RHS.n AS n FROM council_tax AS LHS LEFT JOIN (SELECT cmi_cross_ref_id, master_customer_id, source_system_code, COUNT(*) OVER () AS n FROM cmi_cross_references) AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) WHERE (n >= 1) ORDER BY cmi_cross_ref_id, source_system_code NULLS LAST;

/*
Gold Result:
(10, 'Z_SYS')
(10, 'Z_SYS')
(20, 'A_SYS')
*/

-- Prediction Query
SELECT T1.cmi_cross_ref_id, T1.source_system_code FROM CMI_Cross_References AS T1 JOIN Council_Tax AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id GROUP BY T1.cmi_cross_ref_id HAVING COUNT(*) >= 1;

/*
Prediction Result:
(10, 'Z_SYS')
(20, 'A_SYS')
*/