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
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1, 1, 'cmi_683240');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (2, 1, 'cmi_683240');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (3, 1, 'cmi_683240');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (4, 4, 'cmi_683240');

INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (5, 5, 'cmi_683240');

-- Inserting into table: customer_master_index --
INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (1, 't3__a3c82c');

INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (3, 't3__a3c82c');

INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (2, 'cus_150d45');

INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (4, 'Schmidt ,  Kertzmann and Lubowitz');

INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (5, NULL);

-- Inserting into table: rent_arrears --
INSERT INTO "rent_arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (1, 1);

INSERT INTO "rent_arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (-2147483647, 1);

INSERT INTO "rent_arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (-2147483646, 1);

INSERT INTO "rent_arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (-2147483645, 1);

INSERT INTO "rent_arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (2, 4);

INSERT INTO "rent_arrears" ("council_tax_id", "cmi_cross_ref_id") VALUES (3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT council_tax_id FROM (SELECT LHS.master_customer_id AS master_customer_id, LHS.cmi_details AS cmi_details, LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM (SELECT LHS.master_customer_id AS master_customer_id, LHS.cmi_details AS cmi_details, RHS.cmi_cross_ref_id AS cmi_cross_ref_id, RHS.source_system_code AS source_system_code FROM customer_master_index AS LHS INNER JOIN cmi_cross_references AS RHS ON (LHS.master_customer_id = RHS.master_customer_id)) AS LHS INNER JOIN rent_arrears AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY council_tax_id;

/*
Gold Result:
(-2147483647,)
(-2147483646,)
(-2147483645,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT T1.council_tax_id FROM Rent_Arrears AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id JOIN Customer_Master_Index AS T3 ON T3.master_customer_id = T2.master_customer_id WHERE T3.cmi_details <> 'Schmidt ,  Kertzmann and Lubowitz';

/*
Prediction Result:
(-2147483647,)
(-2147483646,)
(-2147483645,)
(1,)
*/