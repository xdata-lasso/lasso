-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (30, 'Zeta Bank', 50, 'NYC', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (10, 'Alpha Bank', 100, 'Buffalo', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (20, 'Alpha Bank', 150, 'Albany', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (5, 'Beta Bank', 200, 'NYC', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (40, NULL, 75, 'Syracuse', 'New York');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "bname" FROM "bank" WHERE ("state" = 'New York') ORDER BY bname, bank.branch_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Bank',)
('Alpha Bank',)
('Beta Bank',)
('Zeta Bank',)
*/

-- Prediction Query
SELECT bname FROM bank WHERE state = 'New York';

/*
Prediction Result:
('Beta Bank',)
('Alpha Bank',)
('Alpha Bank',)
('Zeta Bank',)
(None,)
*/