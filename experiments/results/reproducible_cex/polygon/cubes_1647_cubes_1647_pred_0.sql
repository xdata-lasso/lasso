-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (16, '24', 24, '24', '24');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (24, '24', 24, '24', '24');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('21', 24, NULL, '22', 23, 24, -72, '25');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('26', 24, '27', NULL, NULL, 24, -70, '25');
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('18', 21, 16, '24', 24);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('17', 26, 24, '24', 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT credit_score, cust_name, AVG(credit_score) AS meancredit_score FROM (SELECT cust_id, cust_name, acc_type, acc_bal, no_of_loans, credit_score, no_of_loans AS branch_id, state, cust_id_other, cust_name_other, acc_type_other, acc_bal_other, no_of_loans_other, credit_score_other FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.cust_id AS cust_id_other, RHS.cust_name AS cust_name_other, RHS.acc_type AS acc_type_other, RHS.acc_bal AS acc_bal_other, RHS.no_of_loans AS no_of_loans_other, RHS.credit_score AS credit_score_other FROM customer AS LHS INNER JOIN customer AS RHS ON (LHS.no_of_loans = RHS.branch_id AND LHS.state = RHS.state))) GROUP BY credit_score, cust_name) ORDER BY cust_name;

/*
Gold Result:
(None,)
('27',)
*/

-- Prediction Query
SELECT cust_name FROM customer WHERE credit_score < (SELECT AVG(credit_score) FROM customer);

/*
Prediction Result:
(None,)
*/