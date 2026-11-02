-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1033, 'site');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1130, 'sit');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1034, 1033, 'face', '1986-06-17', '1987-07-18');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1131, 1130, 'wait', '1976-10-19', '1977-11-20');
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1035, 1034, '1988-08-19', '1989-09-20', 1036, 1037);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1132, 1131, '1978-01-21', '1979-02-22', 1133, 1134);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1038, 1035, '1990-10-21', '1994-03-02', 1045, 1049, 1053);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1039, 1035, '1990-10-22', '1994-03-03', 1056.0, 1062.0, 1068.0);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1040, 1035, '1990-10-23', '1994-03-04', 1067.0, 1075.0, 1083.0);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1041, 1035, '1990-10-24', '1994-03-05', 1078.0, 1088.0, 1098.0);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1135, 1132, '1980-03-23', '1984-07-04', 1142, 1146, 1150);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1136, 1132, '1980-03-24', '1984-07-05', 1153.0, 1159.0, 1165.0);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1137, 1132, '1980-03-25', '1984-07-06', 1164.0, 1172.0, 1180.0);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1138, 1132, '1980-03-26', '1984-07-07', 1175.0, 1185.0, 1195.0);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1057, 1038, 'election', '1998-07-06', 1061);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1058, 1038, 'election', '1998-07-07', 1072.0);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1059, 1038, 'election', '1998-07-08', 1083.0);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1060, 1038, 'election', '1998-07-09', 1094.0);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1154, 1135, NULL, '1988-11-08', 1158);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1155, 1135, NULL, '1988-11-09', 1169.0);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1156, 1135, NULL, '1988-11-10', 1180.0);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1157, 1135, NULL, '1988-11-11', 1191.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT * FROM (SELECT * FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) DESC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('election',)
*/