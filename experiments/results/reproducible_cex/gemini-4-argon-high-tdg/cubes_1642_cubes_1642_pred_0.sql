-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Downtown', 100, 'Austin', 'Texas');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'Uptown', 150, 'Dallas', 'Texas');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('101', 1, 'Zara', 'S', 5000, 1, 720, 'Texas');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('102', 1, 'Alice', 'C', 12000, 2, 780, 'Texas');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('103', 2, 'Bob', 'S', 3000, 1, 650, 'Texas');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('104', 2, 'Diana', 'C', 8000, 1, 700, 'Texas');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('101', '103', '1', 'Auto', 15000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('102', '102', '1', 'Personal', 5000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('103', '101', '2', 'Mortgages', 250000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L99', '104', '2', 'Auto', 20000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cust_name" FROM (SELECT "cust_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "branch_id", "state", "loan_type", "cust_id_other", "branch_id_other", "amount", "cust_id" AS "loan_id" FROM (SELECT "LHS"."cust_id" AS "cust_id", "LHS"."cust_name" AS "cust_name", "LHS"."acc_type" AS "acc_type", "LHS"."acc_bal" AS "acc_bal", "LHS"."no_of_loans" AS "no_of_loans", "LHS"."credit_score" AS "credit_score", "LHS"."branch_id" AS "branch_id", "LHS"."state" AS "state", "RHS"."loan_type" AS "loan_type", "RHS"."cust_id" AS "cust_id_other", "RHS"."branch_id" AS "branch_id_other", "RHS"."amount" AS "amount" FROM "customer" AS "LHS" INNER JOIN "loan" AS "RHS" ON ("LHS"."cust_id" = "RHS"."loan_id"))) WHERE ("loan_type" <> 'Mortgages') ORDER BY cust_name, "cust_name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zara',)
*/

-- Prediction Query
SELECT cust_name FROM customer EXCEPT SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE T2.loan_type = 'Mortgages';

/*
Prediction Result:
('Alice',)
('Bob',)
('Diana',)
*/