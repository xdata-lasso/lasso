-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1004, 'Jonathan Johnson', 1005, 'Lake Debra', 'Ohio');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('kind', 1004, 'Kevin Pacheco', 'according', 49, 1006, 49, 'Wisconsin');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('collection', 1004, 'Kevin Pacheco', 'according', 51, 1006, 49, 'Wisconsin');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('save', 1004, 'Kevin Pacheco', 'according', 53, 1006, 49, 'Wisconsin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanacc_bal AS avg_acc_bal_, acc_type FROM (SELECT acc_type, state, AVG(acc_bal) AS meanacc_bal FROM (SELECT * FROM customer WHERE (acc_bal > 50 AND credit_score <= 50)) GROUP BY acc_type, state) ORDER BY avg_acc_bal_, acc_type NULLS LAST;

/*
Gold Result:
(52.0, 'according')
*/

-- Prediction Query
SELECT AVG(acc_bal), acc_type FROM customer WHERE credit_score < 50 GROUP BY acc_type;

/*
Prediction Result:
(51.0, 'according')
*/