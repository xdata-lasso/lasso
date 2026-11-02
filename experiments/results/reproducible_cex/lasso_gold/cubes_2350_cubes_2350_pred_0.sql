-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1027, 'require');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1028, 'sit');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1029, 'wait');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1030, 'offer');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1047, 'all');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1048, 'better');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1049, 'discover');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1050, 'early');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1031, 1027, 'begin', '1990-10-21', '1994-03-02');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1032, 1027, 'performance', '1990-10-22', '1994-03-03');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1033, 1027, 'knowledge', '1990-10-23', '1994-03-04');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1034, 1027, 'almost', '1990-10-24', '1994-03-05');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1051, 1047, 'mouth', '1977-04-14', '1981-08-18');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1052, 1047, 'play', '1977-04-15', '1981-08-19');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1053, 1047, 'agreement', '1977-04-16', '1981-08-20');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1054, 1047, 'option', '1977-04-17', '1981-08-21');
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1035, 1031, '1998-07-06', '1973-11-10', 1059, 1063);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1036, 1031, '1998-07-07', '2099-12-31', 1050.0, 1056.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1037, 1031, '1998-07-08', '2099-12-31', 1061.0, 1069.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1038, 1031, '1998-07-09', '2099-12-31', 1072.0, 1082.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1055, 1051, '1985-01-22', '1973-11-10', 1039, 1043);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1056, 1051, '1985-01-23', '2099-12-31', 1070.0, 1076.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1057, 1051, '1985-01-24', '2099-12-31', 1081.0, 1089.0);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1058, 1051, '1985-01-25', '2099-12-31', 1092.0, 1102.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_claim_made FROM (SELECT * FROM (SELECT * FROM claims ORDER BY date_claim_settled, claims.claim_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('1998-07-06',)
*/

-- Prediction Query
SELECT Date_Claim_Made FROM Claims ORDER BY Date_Claim_Made ASC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1985-01-22',)
*/