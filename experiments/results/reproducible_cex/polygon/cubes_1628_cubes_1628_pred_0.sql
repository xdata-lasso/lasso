-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (13, '26', 26, '26', '26');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (19, '26', 26, '26', '26');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('18', 19, '26', '27', 28, 29, NULL, '31');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('17', NULL, '26', NULL, NULL, NULL, 35, NULL);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('16', 17, 19, '25', -122);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('15', 18, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT credit_score, cust_name, SUM(amount) AS sumamount FROM (SELECT LHS.loan_id AS loan_id, LHS.loan_type AS loan_type, LHS.cust_id AS cust_id, LHS.branch_id AS branch_id, LHS.amount AS amount, RHS.cust_name AS cust_name, RHS.acc_type AS acc_type, RHS.acc_bal AS acc_bal, RHS.no_of_loans AS no_of_loans, RHS.credit_score AS credit_score, RHS.branch_id AS branch_id_other, RHS.state AS state FROM loan AS LHS INNER JOIN customer AS RHS ON (LHS.cust_id = RHS.cust_id)) GROUP BY credit_score, cust_name) ORDER BY cust_name;

/*
Gold Result:
('26',)
('26',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name ORDER BY SUM(T2.amount), T1.cust_name NULLS LAST;

/*
Prediction Result:
('26',)
*/