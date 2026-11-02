-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Downtown', 100, 'NYC', 'NY');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'Uptown', 200, 'LA', 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('101', 1, 'Zack', 'S', 5000, 1, 750, 'NY');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('102', 2, 'Alice', 'C', 3000, 2, 680, 'CA');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('103', 1, NULL, 'S', 1000, 0, 600, 'NY');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('101', '102', '2', 'Mortgages', 250000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('102', '103', '1', 'Mortgages', 150000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('103', '101', '2', 'Mortgages', 300000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cust_name" FROM (SELECT "cust_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "branch_id", "state", "loan_type", "cust_id_other", "branch_id_other", "amount", "cust_id" AS "loan_id" FROM (SELECT "LHS"."cust_id" AS "cust_id", "LHS"."cust_name" AS "cust_name", "LHS"."acc_type" AS "acc_type", "LHS"."acc_bal" AS "acc_bal", "LHS"."no_of_loans" AS "no_of_loans", "LHS"."credit_score" AS "credit_score", "LHS"."branch_id" AS "branch_id", "LHS"."state" AS "state", "RHS"."loan_type" AS "loan_type", "RHS"."cust_id" AS "cust_id_other", "RHS"."branch_id" AS "branch_id_other", "RHS"."amount" AS "amount" FROM "customer" AS "LHS" INNER JOIN "loan" AS "RHS" ON ("LHS"."cust_id" = "RHS"."loan_id"))) WHERE ("loan_type" = 'Mortgages' AND "loan_type" <> 'Auto') ORDER BY cust_name, "cust_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE loan_type = 'Mortgages' INTERSECT SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE loan_type = 'Auto';

/*
Prediction Result:
*/