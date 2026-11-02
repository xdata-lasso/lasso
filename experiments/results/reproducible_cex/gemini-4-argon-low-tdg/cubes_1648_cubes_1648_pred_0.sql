-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Main', 100, 'NYC', 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 1, 'Alice', 'S', 200, 1, 100, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 1, 'Bob', 'C', 150, 0, 99, 'CA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C03', 1, 'Charlie', 'S', 50, 2, 50, 'TX');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C04', 1, 'David', 'C', 51, 1, 50, 'FL');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C05', 1, 'Eve', 'S', 40, 0, 80, 'WA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C06', 1, 'Frank', 'C', 100, 3, 120, 'NV');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT acc_bal AS sum_acc_bal_, state FROM customer WHERE (credit_score >= 100 OR credit_score >= acc_bal) ORDER BY sum_acc_bal_, customer.cust_id NULLS LAST;

/*
Gold Result:
(40, 'WA')
(50, 'TX')
(100, 'NV')
(200, 'NY')
*/

-- Prediction Query
SELECT SUM(acc_bal), state FROM customer WHERE credit_score > 100 GROUP BY state;

/*
Prediction Result:
(100, 'NV')
*/