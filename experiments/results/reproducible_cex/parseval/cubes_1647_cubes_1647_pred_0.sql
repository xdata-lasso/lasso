-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (-2147483648, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1, 'ban_7e662a', -59984348, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_99e8c8', -2147483648, 'cus_072710', 'cus_b60644', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('lhs_c37f46', 1, 'lhs_1037e6', 'lhs_216484', 1, 1, 1, 'lhs_4b8e63');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('rhs_ede94c', 1, 'rhs_90610e', 'rhs_9093aa', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_a1d844', 1, 'cus_fae7a5', 'cus_ce9d5c', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('lhs_a867ef', 1, 'lhs_8f45b9', 'lhs_668f57', 1, 1, 1, 'lhs_5e1ec7');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('rhs_f2234d', -2147483648, 'rhs_42f20b', 'rhs_6394e4', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('`', 1, 'cus_47fcee', '1', 1115440883, 1644814318, 1465859724, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('@', 1, 'cus_47fcee', '1', 700293388, 906324270, 1908028688, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('E', -2147483648, 'cus_47fcee', '1', 1072996612, 13244799, -1659388584, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('A', -2147483648, 'cus_47fcee', '1', -1377057208, -841692980, -1364429300, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_11', -2147483648, 'q_2_d3a216', '1', 462974032, -1137908826, -918961358, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_12', -2147483648, 'q_2_d3a216', '1', -1823627488, -1209887326, -1399556171, 'cus_2653a8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT credit_score, cust_name, AVG(credit_score) AS meancredit_score FROM (SELECT cust_id, cust_name, acc_type, acc_bal, no_of_loans, credit_score, no_of_loans AS branch_id, state, cust_id_other, cust_name_other, acc_type_other, acc_bal_other, no_of_loans_other, credit_score_other FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.cust_id AS cust_id_other, RHS.cust_name AS cust_name_other, RHS.acc_type AS acc_type_other, RHS.acc_bal AS acc_bal_other, RHS.no_of_loans AS no_of_loans_other, RHS.credit_score AS credit_score_other FROM customer AS LHS INNER JOIN customer AS RHS ON (LHS.no_of_loans = RHS.branch_id AND LHS.state = RHS.state))) GROUP BY credit_score, cust_name) ORDER BY cust_name;

/*
Gold Result:
('cus_072710',)
('cus_fae7a5',)
('lhs_1037e6',)
('lhs_8f45b9',)
('rhs_42f20b',)
('rhs_90610e',)
*/

-- Prediction Query
SELECT cust_name FROM customer WHERE credit_score < (SELECT AVG(credit_score) FROM customer);

/*
Prediction Result:
('cus_47fcee',)
('cus_47fcee',)
('q_2_d3a216',)
('q_2_d3a216',)
*/