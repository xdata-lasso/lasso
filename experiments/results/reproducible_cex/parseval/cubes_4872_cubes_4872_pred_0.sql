-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483648, 'cus_8a62ed');

-- Inserting into table: customer_policies --
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'cus_81b2ed', '2025-06-17', '2021-11-08');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483647, -2147483648, 'cus_81b2ed', '2023-03-15', '2023-11-15');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483646, -2147483648, 'cus_81b2ed', '2022-12-08', '2020-06-07');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (2, -2147483648, 'cus_81b2ed', '2023-04-14', '2021-12-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (3, -2147483648, 'cus_81b2ed', '2020-06-08', '2025-04-30');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483645, -2147483648, 'cus_81b2ed', '2021-02-11', '2023-07-13');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483642, -2147483648, 'G', '2020-12-20', '2020-09-26');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483641, -2147483648, 'G', '2021-05-05', '2023-01-06');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483640, -2147483648, 'A', '2020-01-20', '2024-12-12');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483639, -2147483648, 'O', '2022-09-17', '2023-08-23');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483638, -2147483648, 'O', '2021-03-30', '2023-04-22');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483637, -2147483648, 'A', '2023-11-30', '2020-05-06');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483636, -2147483648, 'C', '2022-08-24', '2025-08-22');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483635, -2147483648, 'C', '2023-08-07', '2021-04-10');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483634, -2147483648, 'A', '2020-08-14', '2022-01-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483633, -2147483648, 'I', '2023-05-30', '2021-05-27');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483632, -2147483648, 'I', '2020-04-02', '2022-04-29');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483631, -2147483648, 'A', '2023-01-01', '2022-02-26');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483630, -2147483648, 'cus_81b2ed', '2022-08-20', '2022-07-21');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483629, -2147483648, 'cus_81b2ed', '2021-06-28', '2021-06-03');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483628, -2147483648, 'cus_81b2ed', '2025-06-27', '2023-09-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483627, -2147483648, NULL, '2023-11-17', '2025-09-21');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483626, -2147483648, NULL, '2021-12-14', '2020-12-06');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483625, -2147483648, NULL, '2024-07-24', '2024-09-12');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (4, -2147483648, 'cus_297b00', '2021-11-08', '2025-06-13');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (5, -2147483648, 'cus_297b00', '2023-11-15', '2024-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT end_date, policy_type_code, n, MAX(n) OVER () AS maxn FROM (SELECT end_date, policy_type_code, COUNT(*) AS n FROM customer_policies GROUP BY end_date, policy_type_code)) ORDER BY maxn) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT Policy_Type_Code FROM Customer_Policies GROUP BY Policy_Type_Code ORDER BY COUNT(*) DESC, Policy_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('cus_81b2ed',)
*/