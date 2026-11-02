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
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (1, 'Zeta');
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (2, 'Alpha');
INSERT INTO "Customer_Master_Index" ("master_customer_id", "cmi_details") VALUES (3, 'Beta');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (10, 1, 'Tax');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (20, 2, 'Tax');
INSERT INTO "CMI_Cross_References" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (30, 3, 'Rent');
INSERT INTO "Council_Tax" ("council_tax_id", "cmi_cross_ref_id") VALUES (100, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cmi_details" FROM (SELECT "LHS"."master_customer_id" AS "master_customer_id", "LHS"."cmi_details" AS "cmi_details", "RHS"."cmi_cross_ref_id" AS "cmi_cross_ref_id", "RHS"."source_system_code" AS "source_system_code" FROM "customer_master_index" AS "LHS" INNER JOIN "cmi_cross_references" AS "RHS" ON ("LHS"."master_customer_id" = "RHS"."master_customer_id")) WHERE ("source_system_code" = 'Tax') ORDER BY cmi_details, "cmi_details" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T1.cmi_details FROM Customer_Master_Index AS T1 JOIN CMI_Cross_References AS T2 ON T1.master_customer_id = T2.master_customer_id WHERE T2.source_system_code = 'Tax';

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/