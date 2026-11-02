-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate outputs (SELECT vs SELECT DISTINCT) when one customer has multiple loans > 3000, and when different customers share the same name.
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Central', 50, 'NY', 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 1, 'John', 'S', 1000, 2, 700, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 1, 'John', 'C', 2000, 1, 720, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C03', 1, 'Anna', 'S', 1500, 1, 680, 'NY');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L01', 'C01', '1', 'Auto', 4000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L02', 'C01', '1', 'Home', 5000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L03', 'C02', '1', 'Auto', 3500);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L04', 'C03', '1', 'Personal', 4500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT LHS.loan_id AS loan_id, LHS.loan_type AS loan_type, LHS.cust_id AS cust_id, LHS.branch_id AS branch_id, LHS.amount AS amount, RHS.cust_name AS cust_name, RHS.acc_type AS acc_type, RHS.acc_bal AS acc_bal, RHS.no_of_loans AS no_of_loans, RHS.credit_score AS credit_score, RHS.branch_id AS branch_id_other, RHS.state AS state FROM loan AS LHS INNER JOIN customer AS RHS ON (LHS.cust_id = RHS.cust_id)) WHERE (amount > 3000) ORDER BY cust_name;

/*
Gold Result:
('Anna',)
('John',)
('John',)
('John',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE amount > 3000;

/*
Prediction Result:
('John',)
('John',)
('John',)
('Anna',)
*/