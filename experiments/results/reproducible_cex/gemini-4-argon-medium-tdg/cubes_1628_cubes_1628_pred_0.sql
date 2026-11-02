-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Downtown', 100, 'NY', 'NY');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'Uptown', 150, 'LA', 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C1', 1, 'Charlie', 'S', 5000, 2, 700, 'NY');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C2', 1, 'Alice', 'C', 10000, 1, 750, 'NY');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C3', 2, 'Alice', 'S', 3000, 1, 600, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C4', 2, 'Bob', 'C', 2000, 0, 800, 'CA');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L1', 'C1', '1', 'Auto', 10000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L2', 'C1', '2', 'Home', 50000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L3', 'C2', '1', 'Personal', 5000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L4', 'C3', '2', 'Auto', 15000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT credit_score, cust_name, SUM(amount) AS sumamount FROM (SELECT LHS.loan_id AS loan_id, LHS.loan_type AS loan_type, LHS.cust_id AS cust_id, LHS.branch_id AS branch_id, LHS.amount AS amount, RHS.cust_name AS cust_name, RHS.acc_type AS acc_type, RHS.acc_bal AS acc_bal, RHS.no_of_loans AS no_of_loans, RHS.credit_score AS credit_score, RHS.branch_id AS branch_id_other, RHS.state AS state FROM loan AS LHS INNER JOIN customer AS RHS ON (LHS.cust_id = RHS.cust_id)) GROUP BY credit_score, cust_name) ORDER BY cust_name;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name ORDER BY SUM(T2.amount), T1.cust_name NULLS LAST;

/*
Prediction Result:
('Alice',)
('Charlie',)
*/