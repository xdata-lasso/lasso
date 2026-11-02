-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'B1', 10, 'C1', 'S1');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (2, 'B2', 20, 'C2', 'S2');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (3, 'B3', 30, 'C3', 'S3');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C1', 1, 'Zoe', 'S', 100, 99, 700, 'S1');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C2', 2, 'Alice', 'C', 200, 2, 750, 'S2');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C3', 3, 'Alice', 'S', 300, 99, 800, 'S3');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C4', 1, 'Bob', 'C', 400, 1, 650, 'S1');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L1', 'C1', '2', 'Auto', 5000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L2', 'C2', '1', 'Home', 10000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L3', 'C2', '3', 'Auto', 2000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L4', 'C3', '1', 'Edu', 3000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L5', 'C3', '2', 'Home', 4000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L6', 'C3', '3', 'Auto', 1000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L7', 'C4', '1', 'Edu', 1500);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L8', 'C4', '1', 'Auto', 2500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state FROM customer AS LHS INNER JOIN (SELECT cust_id, COUNT(*) AS n FROM loan GROUP BY cust_id) AS RHS ON (LHS.branch_id = RHS.n AND LHS.cust_id = RHS.cust_id)) ORDER BY cust_name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name HAVING COUNT(*) > 1;

/*
Prediction Result:
('Alice',)
('Bob',)
*/