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
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (1, 'Customer A');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (2, 'Customer B');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (3, 'Customer C');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (10, 1, 'Electoral');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (20, 2, 'Tax');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (30, 3, 'Benefits');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (40, NULL, 'Electoral');
INSERT INTO CMI_Cross_References (cmi_cross_ref_id, master_customer_id, source_system_code) VALUES (50, 1, NULL);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (500, 10);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (100, 10);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (300, 40);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (200, 20);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (400, 30);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (600, 50);
INSERT INTO Electoral_Register (electoral_register_id, cmi_cross_ref_id) VALUES (700, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "electoral_register_id" FROM (SELECT "LHS"."electoral_register_id" AS "electoral_register_id", "LHS"."cmi_cross_ref_id" AS "cmi_cross_ref_id", "RHS"."master_customer_id" AS "master_customer_id", "RHS"."source_system_code" AS "source_system_code" FROM "electoral_register" AS "LHS" INNER JOIN (SELECT * FROM "cmi_cross_references" WHERE ("source_system_code" = 'Electoral' AND "source_system_code" <> 'Tax')) AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY electoral_register_id, "electoral_register_id" NULLS LAST;

/*
Gold Result:
(100,)
(300,)
(500,)
*/

-- Prediction Query
SELECT T1.electoral_register_id FROM Electoral_Register AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id WHERE T2.source_system_code = 'Electoral' OR T2.source_system_code = 'Tax';

/*
Prediction Result:
(100,)
(200,)
(300,)
(500,)
*/