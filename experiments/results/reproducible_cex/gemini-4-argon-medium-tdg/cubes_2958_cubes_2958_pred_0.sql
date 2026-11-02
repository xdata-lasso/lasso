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
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (55, NULL);
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (77, 55, NULL);
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (88, 55, '');
INSERT INTO "Rent_Arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (303, 88);
INSERT INTO "Rent_Arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (101, 77);
INSERT INTO "Rent_Arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (202, 77);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT council_tax_id FROM (SELECT LHS.master_customer_id AS master_customer_id, LHS.cmi_details AS cmi_details, LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM (SELECT LHS.master_customer_id AS master_customer_id, LHS.cmi_details AS cmi_details, RHS.cmi_cross_ref_id AS cmi_cross_ref_id, RHS.source_system_code AS source_system_code FROM customer_master_index AS LHS INNER JOIN cmi_cross_references AS RHS ON (LHS.master_customer_id = RHS.master_customer_id)) AS LHS INNER JOIN rent_arrears AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY council_tax_id;

/*
Gold Result:
(101,)
(202,)
(303,)
*/

-- Prediction Query
SELECT T1.council_tax_id FROM Rent_Arrears AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id JOIN Customer_Master_Index AS T3 ON T3.master_customer_id = T2.master_customer_id WHERE T3.cmi_details <> 'Schmidt ,  Kertzmann and Lubowitz';

/*
Prediction Result:
*/