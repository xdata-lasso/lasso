-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE amount <> 5000 boundary conditions (4999, 5000, 5001, NULL).
-- 2. GROUP BY cust_id (customer with multiple valid loans should appear only once).
-- 3. INNER JOIN vs LEFT JOIN (customer with no loans, customer with only 5000 loan, customer with NULL loan).
-- 4. Duplicate output rows (two distinct customers with identical cust_name and acc_type to kill DISTINCT mutants).
-- 5. Cross-branch loans (customer's branch_ID differs from loan's branch_ID to kill natural join / branch_ID join mutants).
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Main', 100, 'NYC', 'NY');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (2, 'West', 50, 'LA', 'CA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C1', 1, 'Alice', 'S', 1000, 2, 700, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C2', 1, 'Bob', 'C', 2000, 1, 650, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C3', 1, 'Charlie', 'S', 1500, 0, 800, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C4', 2, 'Alice', 'S', 3000, 1, 750, 'CA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C5', 2, 'David', 'C', 500, 1, 600, 'CA');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L1', 'C1', '1', 'Auto', 4999);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L2', 'C1', '2', 'Home', 5001);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L3', 'C1', '1', 'Personal', 5000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L4', 'C2', '1', 'Auto', 5000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L5', 'C4', '1', 'Home', 1000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L6', 'C5', '2', 'Personal', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name, acc_type FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.sumamount AS sumamount FROM customer AS LHS INNER JOIN (SELECT cust_id, SUM(amount) AS sumamount FROM loan WHERE (amount <> 5000) GROUP BY cust_id) AS RHS ON (LHS.cust_id = RHS.cust_id)) ORDER BY cust_name, acc_type NULLS LAST;

/*
Gold Result:
('Alice', 'S')
('Alice', 'S')
*/

-- Prediction Query
SELECT T1.cust_name, T1.acc_type FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name HAVING SUM(T2.amount) > 5000;

/*
Prediction Result:
('Alice', 'S')
*/