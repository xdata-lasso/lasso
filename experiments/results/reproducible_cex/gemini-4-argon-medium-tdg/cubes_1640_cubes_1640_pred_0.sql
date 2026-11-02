-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (10, 'Main', 50, 'Boston', 'MA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C1', 10, 'David', 'S', 100, 1, 800, 'MA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C2', 10, 'David', 'C', 200, 1, 650, 'MA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C3', 10, 'David', 'S', 300, 1, NULL, 'MA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C4', 10, 'David', 'C', 400, 1, 800, 'MA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C5', 10, 'Eve', 'S', 500, 1, 700, 'MA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C6', 10, NULL, 'S', 600, 1, 720, 'MA');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L1', 'C1', '10', 'Mortgage', 100000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L2', 'C2', '10', 'Auto', 20000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L3', 'C3', '10', 'Personal', 5000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L4', 'C4', '10', 'Business', 50000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L5', 'C5', '10', 'Student', 10000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L6', 'C6', '10', 'Auto', 15000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cust_name, credit_score FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.loan_id AS loan_id, RHS.loan_type AS loan_type, RHS.branch_id AS branch_id_other, RHS.amount AS amount FROM customer AS LHS INNER JOIN loan AS RHS ON (LHS.cust_id = RHS.cust_id)) ORDER BY cust_name, credit_score NULLS LAST;

/*
Gold Result:
(None, 720)
('David', 650)
('David', 800)
('David', None)
('Eve', 700)
*/

-- Prediction Query
SELECT DISTINCT T1.cust_name, T1.credit_score FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id;

/*
Prediction Result:
('David', 800)
('David', 650)
('David', None)
('Eve', 700)
(None, 720)
*/