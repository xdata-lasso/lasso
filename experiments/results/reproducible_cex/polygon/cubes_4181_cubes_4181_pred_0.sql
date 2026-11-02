-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (18, '655', 655, '655', '655');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (28, '655', 655, '655', '655');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('24', 28, NULL, '25', 26, 27, 655, '29');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('19', 28, NULL, '655', 655, 655, 655, '655');
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('20', 19, 28, '655', 655);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cust_name FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, LHS.mincredit_score AS mincredit_score, RHS.cust_id AS cust_id_other, RHS.cust_name AS cust_name_other, RHS.acc_type AS acc_type_other, RHS.acc_bal AS acc_bal_other, RHS.no_of_loans AS no_of_loans_other, RHS.credit_score AS credit_score_other, RHS.branch_id AS branch_id_other, RHS.state AS state_other, RHS.mincredit_score AS mincredit_score_other FROM (SELECT cust_id, cust_name, acc_type, acc_bal, no_of_loans, credit_score, branch_id, state, MIN(credit_score) OVER () AS mincredit_score FROM customer) AS LHS CROSS JOIN (SELECT cust_id, cust_name, acc_type, acc_bal, no_of_loans, credit_score, branch_id, state, MIN(credit_score) OVER () AS mincredit_score FROM customer) AS RHS) WHERE (credit_score = mincredit_score_other OR credit_score_other < mincredit_score_other) ORDER BY cust_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT cust_name FROM customer ORDER BY credit_score, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/