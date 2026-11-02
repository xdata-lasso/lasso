-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1001, 'purpose');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1002, 'brother');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1003, 'ago');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1004, 'site');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1005, 1001, 'face', '1970-01-01', '1974-05-05');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1006, 1001, 'election', '1970-01-02', '1974-05-06');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1007, 1001, 'dog', '1970-01-03', '1974-05-07');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1008, 1001, 'chair', '1970-01-04', '1974-05-08');
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1009, 1005, '1978-09-09', '1982-02-13', 1013, 1017);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1010, 1005, '1978-09-10', '1982-02-14', 1024.0, 1030.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1011, 1005, '1978-09-11', '1982-02-15', 1035.0, 1043.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1012, 1005, '1978-09-12', '1982-02-16', 1046.0, 1056.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT amount_settled, amount_claimed FROM (SELECT * FROM (SELECT * FROM claims ORDER BY policy_id DESC, claims.claim_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1017, 1013)
*/

-- Prediction Query
SELECT Amount_Settled, Amount_Claimed FROM Claims ORDER BY Amount_Claimed DESC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1056, 1046)
*/