-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1, 'ban_87a9dd', 1, 'ban_15844b', 'Utah');

INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (-2147483647, 'ban_7e662a', 1, 'ban_c7869b', 'Utah');

INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (-2147483646, 'ban_7e662a', 1, 'ban_c7869b', 'Utah');

INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (2, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (3, 'ban_7e662a', -59984348, 'ban_c7869b', 'ban_992a99');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "no_of_customers" AS "avg_no_of_customers_" FROM (SELECT "branch_id", "bname", "no_of_customers", "city", "state", AVG("no_of_customers") OVER () AS "meanno_of_customers" FROM "bank") WHERE ("state" = 'Utah') ORDER BY avg_no_of_customers_;

/*
Gold Result:
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT AVG(no_of_customers) FROM bank WHERE state = 'Utah';

/*
Prediction Result:
(1.0,)
*/