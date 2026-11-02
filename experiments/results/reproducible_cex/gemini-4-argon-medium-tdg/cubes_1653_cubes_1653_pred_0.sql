-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Main', 100, 'NYC', 'NY');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C1', 1, 'Alice', 'S', 50, 1, 50, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C2', 1, 'Bob', 'S', 51, 1, 50, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C3', 1, 'Charlie', 'S', 51, 1, 51, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C4', 1, 'David', 'C', 100, 0, 49, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C5', 1, 'Eve', 'C', 49, 2, 30, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C6', 1, 'Frank', 'S', NULL, 1, 40, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C7', 1, 'Grace', 'S', 80, 1, NULL, 'CA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanacc_bal AS avg_acc_bal_, acc_type FROM (SELECT acc_type, state, AVG(acc_bal) AS meanacc_bal FROM (SELECT * FROM customer WHERE (acc_bal > 50 AND credit_score <= 50)) GROUP BY acc_type, state) ORDER BY avg_acc_bal_, acc_type NULLS LAST;

/*
Gold Result:
(51.0, 'S')
(100.0, 'C')
*/

-- Prediction Query
SELECT AVG(acc_bal), acc_type FROM customer WHERE credit_score < 50 GROUP BY acc_type;

/*
Prediction Result:
(74.5, 'C')
(None, 'S')
*/