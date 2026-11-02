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
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'cus_a71751', '2024-06-15', '2025-06-17');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483647, -2147483648, 'cus_a71751', '2024-06-15', '2025-06-13');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483646, -2147483648, 'cus_a71751', '2024-06-15', '2023-11-15');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483645, -2147483648, 'cus_a71751', '2024-06-15', '2022-12-08');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483644, -2147483648, 'cus_a71751', '2024-06-15', '2021-02-05');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483643, -2147483648, 'cus_a71751', '2024-06-15', '2021-12-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483642, -2147483648, 'cus_a71751', NULL, '2020-06-08');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483641, -2147483648, 'cus_a71751', NULL, '2022-10-19');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483640, -2147483648, 'cus_a71751', NULL, '2023-07-13');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483639, -2147483648, NULL, '2024-06-15', '2020-12-20');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483638, -2147483648, NULL, '2024-06-15', '2025-06-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483637, -2147483648, NULL, '2024-06-15', '2023-01-06');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483636, -2147483648, 'cus_a71751', '2024-06-15', '2020-01-20');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483635, -2147483648, 'cus_a71751', '2024-06-15', '2024-03-30');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483634, -2147483648, 'cus_a71751', '2024-06-15', '2023-08-23');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483633, -2147483648, 'cus_a71751', '2024-06-15', '2021-03-30');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483632, -2147483648, 'cus_a71751', '2024-06-15', '2023-01-03');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483631, -2147483648, 'cus_a71751', '2024-06-15', '2020-05-06');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483630, -2147483648, 'cus_a71751', '2024-06-15', '2022-08-24');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483629, -2147483648, 'cus_a71751', '2024-06-15', '2023-08-07');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483628, -2147483648, 'cus_a71751', '2024-06-15', '2023-10-03');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483627, -2147483648, 'cus_a71751', '2024-06-15', '2022-01-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483626, -2147483648, 'cus_a71751', '2024-06-15', '2023-05-30');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483625, -2147483648, 'cus_a71751', '2024-06-15', '2022-01-16');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483624, -2147483648, 'cus_a71751', '2024-06-15', '2022-04-29');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483623, -2147483648, 'cus_a71751', '2024-06-15', '2023-01-01');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483622, -2147483648, 'cus_a71751', '2024-06-15', '2020-07-11');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483621, -2147483648, 'cus_a71751', '2024-06-15', '2022-07-21');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483620, -2147483648, 'cus_a71751', '2024-06-15', '2021-06-28');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483619, -2147483648, 'cus_a71751', '2024-06-15', '2020-11-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483618, -2147483648, 'cus_a71751', '2024-06-15', '2023-09-04');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483617, -2147483648, 'cus_a71751', '2024-06-15', '2023-11-17');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483616, -2147483648, 'cus_a71751', '2024-06-15', '2021-12-14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_type_code, start_date, COUNT(*) AS n FROM customer_policies GROUP BY policy_type_code, start_date) ORDER BY start_date DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Policy_Type_Code FROM Customer_Policies GROUP BY Policy_Type_Code ORDER BY COUNT(*) DESC, Policy_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('cus_a71751',)
*/