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
-- DATASET 2
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (10, 'Zeta');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (20, 'Beta');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (30, 'Alpha');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (1, 10, 'CODE_B');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (2, 20, 'CODE_A');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (3, 30, 'CODE_A');
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (500, 1);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (900, 2);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (300, 2);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (100, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source_system_code, council_tax_id FROM (SELECT LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.master_customer_id AS master_customer_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM cmi_cross_references AS LHS INNER JOIN benefits_overpayments AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY source_system_code, council_tax_id NULLS LAST;

/*
Gold Result:
('CODE_A', 100)
('CODE_A', 300)
('CODE_A', 900)
('CODE_B', 500)
*/

-- Prediction Query
SELECT T1.source_system_code, T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Benefits_Overpayments AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id ORDER BY T2.council_tax_id, T1.cmi_cross_ref_id NULLS LAST;

/*
Prediction Result:
('CODE_A', 100)
('CODE_A', 300)
('CODE_B', 500)
('CODE_A', 900)
*/