-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Central', 10, 'Austin', 'TX');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (2, 'Westside', 5, 'Dallas', 'TX');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 1, 'Zoe', 'S', 5000, 2, 650, 'TX');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 1, 'Alice', 'C', 1200, 0, 720, 'TX');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C03', 2, 'Bob', 'S', 3000, 3, 800, 'TX');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L01', 'C01', '1', 'Auto', 10000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L02', 'C01', '2', 'Home', 50000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L03', 'C02', '2', 'Personal', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cust_name, credit_score FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.loan_id AS loan_id, RHS.loan_type AS loan_type, RHS.branch_id AS branch_id_other, RHS.amount AS amount FROM customer AS LHS INNER JOIN loan AS RHS ON (LHS.cust_id = RHS.cust_id)) ORDER BY cust_name, credit_score NULLS LAST;

/*
Gold Result:
('Alice', 720)
('Zoe', 650)
*/

-- Prediction Query
SELECT DISTINCT T1.cust_name, T1.credit_score FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id;

/*
Prediction Result:
('Zoe', 650)
('Alice', 720)
*/