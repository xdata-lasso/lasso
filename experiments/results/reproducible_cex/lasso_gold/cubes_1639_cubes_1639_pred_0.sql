-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1069, 'Timothy Duncan', 1070, 'Sanchezfort', 'Nebraska');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('customer', 1069, 'Matthew Gomez', 'item', 1071, 1072, 1073, 'New Jersey');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('customer_z', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('treat', 'customer', 1069, 'shoulder', 3001);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('arm', 'customer_z', 1069, 'shoulder', 3001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT LHS.loan_id AS loan_id, LHS.loan_type AS loan_type, LHS.cust_id AS cust_id, LHS.branch_id AS branch_id, LHS.amount AS amount, RHS.cust_name AS cust_name, RHS.acc_type AS acc_type, RHS.acc_bal AS acc_bal, RHS.no_of_loans AS no_of_loans, RHS.credit_score AS credit_score, RHS.branch_id AS branch_id_other, RHS.state AS state FROM loan AS LHS INNER JOIN customer AS RHS ON (LHS.cust_id = RHS.cust_id)) WHERE (amount > 3000) ORDER BY cust_name;

/*
Gold Result:
(None,)
('Matthew Gomez',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE amount > 3000;

/*
Prediction Result:
('Matthew Gomez',)
(None,)
*/