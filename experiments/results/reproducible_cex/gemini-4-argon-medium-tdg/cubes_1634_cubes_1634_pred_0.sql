-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering, duplicate cust_name (to catch DISTINCT/GROUP BY mutants), and uncorrelated attributes (order of insertion vs cust_name vs numeric attributes).
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Central', 100, 'Boston', 'MA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C03', 1, 'Zack', 'S', 100, 3, 500, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 1, 'Bob', 'C', 500, 1, 700, 'CA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C04', 1, 'Alice', 'S', 300, 0, 800, 'TX');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 1, 'Bob', 'S', 200, 2, 600, 'FL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM customer ORDER BY cust_name, customer.cust_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT cust_name FROM customer ORDER BY acc_bal, customer.cust_id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Bob',)
('Alice',)
('Bob',)
*/