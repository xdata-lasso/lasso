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
INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (1019, 'sit');
INSERT INTO "customer_master_index" ("master_customer_id", "cmi_details") VALUES (1025, 'performance');
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1020, 1019, 'wait');
INSERT INTO "cmi_cross_references" ("cmi_cross_ref_id", "master_customer_id", "source_system_code") VALUES (1026, 1025, 'knowledge');
INSERT INTO "parking_fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (1021, 1020);
INSERT INTO "parking_fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (1024, 1020);
INSERT INTO "parking_fines" ("council_tax_id", "cmi_cross_ref_id") VALUES (1027, 1026);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source_system_code, master_customer_id, council_tax_id FROM (SELECT LHS.cmi_cross_ref_id AS cmi_cross_ref_id, LHS.master_customer_id AS master_customer_id, LHS.source_system_code AS source_system_code, RHS.council_tax_id AS council_tax_id FROM cmi_cross_references AS LHS INNER JOIN parking_fines AS RHS ON (LHS.cmi_cross_ref_id = RHS.cmi_cross_ref_id)) ORDER BY source_system_code, master_customer_id NULLS LAST, council_tax_id NULLS LAST;

/*
Gold Result:
('knowledge', 1025, 1027)
('wait', 1019, 1021)
('wait', 1019, 1024)
*/

-- Prediction Query
SELECT T1.source_system_code, T1.master_customer_id, T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Parking_Fines AS T2 ON T1.cmi_cross_ref_id = T2.cmi_cross_ref_id;

/*
Prediction Result:
('wait', 1019, 1021)
('wait', 1019, 1024)
('knowledge', 1025, 1027)
*/