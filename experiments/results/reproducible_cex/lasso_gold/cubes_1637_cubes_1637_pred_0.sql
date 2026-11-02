-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1001, 'Allison Hill', 1002, 'East Jill', 'Utah');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('sit', 1001, 'Angie Henderson', 'all', 1003, 1004, 1005, 'Colorado');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('discover', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('sit', 'discover', 1001, 'Mortgages', 1006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cust_name" FROM (SELECT "cust_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "branch_id", "state", "loan_type", "cust_id_other", "branch_id_other", "amount", "cust_id" AS "loan_id" FROM (SELECT "LHS"."cust_id" AS "cust_id", "LHS"."cust_name" AS "cust_name", "LHS"."acc_type" AS "acc_type", "LHS"."acc_bal" AS "acc_bal", "LHS"."no_of_loans" AS "no_of_loans", "LHS"."credit_score" AS "credit_score", "LHS"."branch_id" AS "branch_id", "LHS"."state" AS "state", "RHS"."loan_type" AS "loan_type", "RHS"."cust_id" AS "cust_id_other", "RHS"."branch_id" AS "branch_id_other", "RHS"."amount" AS "amount" FROM "customer" AS "LHS" INNER JOIN "loan" AS "RHS" ON ("LHS"."cust_id" = "RHS"."loan_id"))) WHERE ("loan_type" = 'Mortgages' AND "loan_type" <> 'Auto') ORDER BY cust_name, "cust_name" NULLS LAST;

/*
Gold Result:
('Angie Henderson',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE loan_type = 'Mortgages' INTERSECT SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE loan_type = 'Auto';

/*
Prediction Result:
*/