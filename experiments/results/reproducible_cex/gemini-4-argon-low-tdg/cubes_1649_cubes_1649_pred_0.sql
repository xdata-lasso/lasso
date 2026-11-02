-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('New York' vs other states, case sensitivity, prefix matching, NULL),
-- duplicate "bname" preservation (kills DISTINCT mutants), and basic ordering (kills DESC or unsorted mutants).
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (10, 'Zeta Bank', 50, 'NYC', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (20, 'Alpha Bank', 100, 'Albany', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (30, 'Alpha Bank', 150, 'Buffalo', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (40, 'Beta Bank', 200, 'Newark', 'New Jersey');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (50, 'Gamma Bank', 75, 'NYC', 'new york');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (60, 'Delta Bank', 80, 'NYC', 'New York City');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (70, 'Epsilon Bank', 90, 'Boston', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "bname" FROM "bank" WHERE ("state" = 'New York') ORDER BY bname, bank.branch_id NULLS LAST;

/*
Gold Result:
('Alpha Bank',)
('Alpha Bank',)
('Zeta Bank',)
*/

-- Prediction Query
SELECT bname FROM bank WHERE state = 'New York';

/*
Prediction Result:
('Zeta Bank',)
('Alpha Bank',)
('Alpha Bank',)
*/