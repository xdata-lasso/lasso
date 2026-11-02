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
INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (1022, 'sit');
INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (1026, 'offer');
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1023, 1022, 'Tax');
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1025, 1022, 'Tax');
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1027, 1026, 'Tax');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cmi_details" FROM (SELECT "LHS"."master_customer_id" AS "master_customer_id", "LHS"."cmi_details" AS "cmi_details", "RHS"."cmi_cross_ref_id" AS "cmi_cross_ref_id", "RHS"."source_system_code" AS "source_system_code" FROM "customer_master_index" AS "LHS" INNER JOIN "cmi_cross_references" AS "RHS" ON ("LHS"."master_customer_id" = "RHS"."master_customer_id")) WHERE ("source_system_code" = 'Tax') ORDER BY cmi_details, "cmi_details" NULLS LAST;

/*
Gold Result:
('offer',)
('sit',)
('sit',)
*/

-- Prediction Query
SELECT T1.cmi_details FROM Customer_Master_Index AS T1 JOIN CMI_Cross_References AS T2 ON T1.master_customer_id = T2.master_customer_id WHERE T2.source_system_code = 'Tax';

/*
Prediction Result:
('sit',)
('sit',)
('offer',)
*/