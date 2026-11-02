-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1069, 'John Pierce', 1070, 'Allisonchester', 'Indiana');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1075, 'Steven Hayes', 1076, 'East Caleb', 'Alaska');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('per', 1069, 'Monica Harris', 'forget', 1071, 1072, 1073, 'Montana');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('woman', 1075, 'Andre Rivera', 'second', 1072, 1073, 1074, 'South Dakota');
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('remain', 'per', 1069, 'rate', 1074);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('artist', 'woman', 1075, 'drop', 1080);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cust_name, credit_score FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.loan_id AS loan_id, RHS.loan_type AS loan_type, RHS.branch_id AS branch_id_other, RHS.amount AS amount FROM customer AS LHS INNER JOIN loan AS RHS ON (LHS.cust_id = RHS.cust_id)) ORDER BY cust_name, credit_score NULLS LAST;

/*
Gold Result:
('Andre Rivera', 1074)
('Monica Harris', 1073)
*/

-- Prediction Query
SELECT DISTINCT T1.cust_name, T1.credit_score FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id;

/*
Prediction Result:
('Monica Harris', 1073)
('Andre Rivera', 1074)
*/