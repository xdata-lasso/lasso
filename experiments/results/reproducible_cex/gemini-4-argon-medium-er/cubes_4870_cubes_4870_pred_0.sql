-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Cust 1');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (1, 1, 'AUTO', '2020-01-01', '2021-01-01');
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (1, 1, '2020-02-01', '2020-03-01', 100, 100);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1, 1, '2020-02-01', '2020-03-01', 100, 100, 1);
INSERT INTO "Payments" ("Payment_ID", "Settlement_ID", "Payment_Method_Code", "Date_Payment_Made", "Amount_Payment") VALUES (1, 1, 'VISA', '2020-03-02', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method_code_other AS payment_method_code FROM (SELECT LHS.payment_method_code AS payment_method_code, LHS.n AS n, LHS.maxn AS maxn, RHS.payment_method_code AS payment_method_code_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT payment_method_code, n, MAX(n) OVER () AS maxn FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code)) AS LHS CROSS JOIN (SELECT payment_method_code, n, MAX(n) OVER () AS maxn FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code)) AS RHS) WHERE (n < maxn_other AND maxn <= n_other) ORDER BY payment_method_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) DESC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('VISA',)
*/