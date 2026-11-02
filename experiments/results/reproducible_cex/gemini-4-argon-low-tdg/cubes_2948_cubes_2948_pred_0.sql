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
-- Tests basic ordering (out-of-order insertion, negative, zero, positive IDs),
-- opposing sort order on cmi_details to catch wrong ORDER BY column or DESC,
-- and empty child tables to catch unnecessary INNER JOINs.
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (10, 'Alpha');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (2, 'Zulu');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (-5, 'Omega');
INSERT INTO Customer_Master_Index (master_customer_id, cmi_details) VALUES (0, 'Middle');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT master_customer_id, cmi_details FROM customer_master_index ORDER BY master_customer_id;

/*
Gold Result:
(-5, 'Omega')
(0, 'Middle')
(2, 'Zulu')
(10, 'Alpha')
*/

-- Prediction Query
SELECT * FROM customer_master_index ORDER BY cmi_details DESC, customer_master_index.master_customer_id NULLS LAST;

/*
Prediction Result:
(2, 'Zulu')
(-5, 'Omega')
(0, 'Middle')
(10, 'Alpha')
*/