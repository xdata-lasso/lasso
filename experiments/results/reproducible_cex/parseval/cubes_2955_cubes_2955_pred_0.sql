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
-- Inserting into table: cmi_cross_references --
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1, -2147483648, 'Tax');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (2, -2147483648, 'Tax');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (3, -2147483648, 'cmi_683240');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (4, -2147483648, 'Electoral');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (5, -2147483648, 't2__4045fa');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (6, -2147483648, NULL);

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (7, -2147483648, NULL);

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (8, -2147483648, NULL);

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (9, -2147483648, NULL);

-- Inserting into table: customer_master_index --
INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (-2147483648, 'cus_150d45');

-- Inserting into table: electoral_register --
INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (1, 1);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (3, 1);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (2, 4);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (4, 5);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (5, 6);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (6, 7);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (7, 8);

INSERT INTO "electoral_register" ("electoral_register_id", "cmi_cross_ref_id") VALUES (8, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "electoral_register_id" FROM (SELECT "LHS"."electoral_register_id" AS "electoral_register_id", "LHS"."cmi_cross_ref_id" AS "cmi_cross_ref_id", "RHS"."master_customer_id" AS "master_customer_id", "RHS"."source_system_code" AS "source_system_code" FROM "electoral_register" AS "LHS" INNER JOIN (SELECT * FROM "cmi_cross_references" WHERE ("source_system_code" = 'Electoral' AND "source_system_code" <> 'Tax')) AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY electoral_register_id, "electoral_register_id" NULLS LAST;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT T1.electoral_register_id FROM Electoral_Register AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id WHERE T2.source_system_code = 'Electoral' OR T2.source_system_code = 'Tax';

/*
Prediction Result:
(1,)
(2,)
(3,)
*/