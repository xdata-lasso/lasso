-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_28a45b', 1, 'cus_c418e2', 'cus_b9c627', 51, 1, 50, 'cus_1bf95e');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_e5dce7', 1, 'cus_eeb95a', 'cus_b6745c', 51, 1, 50, 'cus_766195');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanacc_bal AS avg_acc_bal_, acc_type FROM (SELECT acc_type, state, AVG(acc_bal) AS meanacc_bal FROM (SELECT * FROM customer WHERE (acc_bal > 50 AND credit_score <= 50)) GROUP BY acc_type, state) ORDER BY avg_acc_bal_, acc_type NULLS LAST;

/*
Gold Result:
(51.0, 'cus_b6745c')
(51.0, 'cus_b9c627')
*/

-- Prediction Query
SELECT AVG(acc_bal), acc_type FROM customer WHERE credit_score < 50 GROUP BY acc_type;

/*
Prediction Result:
*/