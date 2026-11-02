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
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (100, 'Customer A');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (200, 'Customer B');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (300, 'Customer C');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (400, 'Customer D');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (1, 400, 'Tax');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (10, 200, 'Electoral');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (20, 300, 'Electoral');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (30, 100, 'Electoral');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (40, 100, 'Tax');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (50, 200, 'Parking');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (60, 300, 'Electoral');
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (300, 10);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (100, 20);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (200, 30);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (400, 40);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (500, 50);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (10, 1);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (600, NULL);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (11, 10);
INSERT INTO Council_Tax (council_tax_id, cmi_cross_ref_id) VALUES (12, 40);
INSERT INTO Business_Rates (business_rates_id, cmi_cross_ref_id) VALUES (21, 10);
INSERT INTO Benefits_Overpayments (council_tax_id, cmi_cross_ref_id) VALUES (31, 20);
INSERT INTO Parking_Fines (council_tax_id, cmi_cross_ref_id) VALUES (41, 50);
INSERT INTO Rent_Arrears (council_tax_id, cmi_cross_ref_id) VALUES (51, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "electoral_register_id" FROM (SELECT "LHS"."electoral_register_id" AS "electoral_register_id", "LHS"."cmi_cross_ref_id" AS "cmi_cross_ref_id", "RHS"."master_customer_id" AS "master_customer_id", "RHS"."source_system_code" AS "source_system_code" FROM "electoral_register" AS "LHS" INNER JOIN (SELECT * FROM "cmi_cross_references" WHERE ("source_system_code" = 'Electoral' AND "source_system_code" <> 'Tax')) AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY electoral_register_id, "electoral_register_id" NULLS LAST;

/*
Gold Result:
(100,)
(200,)
(300,)
*/

-- Prediction Query
SELECT T1.electoral_register_id FROM Electoral_Register AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id WHERE T2.source_system_code = 'Electoral' OR T2.source_system_code = 'Tax';

/*
Prediction Result:
(10,)
(100,)
(200,)
(300,)
(400,)
*/