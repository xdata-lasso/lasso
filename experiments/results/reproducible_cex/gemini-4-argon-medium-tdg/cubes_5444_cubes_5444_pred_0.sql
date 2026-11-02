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
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (20, 2, 'SYS_A');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (30, NULL, 'SYS_A');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (40, 1, 'SYS_C');
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (105, 10);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (101, 10);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (202, 20);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (201, 30);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (301, NULL);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (901, 10);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (902, 40);
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (801, 10);
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (802, 40);
INSERT INTO Rent_Arrears (council_tax_id, cmi_cross_ref_id) VALUES (701, 10);
INSERT INTO Rent_Arrears (council_tax_id, cmi_cross_ref_id) VALUES (702, 40);
INSERT INTO Business_Rates (business_rates_id, cmi_cross_ref_id) VALUES (601, 10);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (501, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source_system_code, council_tax_id FROM (SELECT LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.master_customer_id AS master_customer_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM cmi_cross_references AS LHS INNER JOIN benefits_overpayments AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY source_system_code, council_tax_id NULLS LAST;

/*
Gold Result:
('SYS_A', 201)
('SYS_A', 202)
('SYS_B', 101)
('SYS_B', 105)
*/

-- Prediction Query
SELECT T1.source_system_code, T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Benefits_Overpayments AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id ORDER BY T2.council_tax_id, T1.cmi_cross_ref_id NULLS LAST;

/*
Prediction Result:
('SYS_B', 101)
('SYS_B', 105)
('SYS_A', 201)
('SYS_A', 202)
*/