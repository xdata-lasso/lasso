-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (9, '20', 20, '20', '20');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (8, '20', 20, '20', '20');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('11', NULL, '13', NULL, NULL, -1, 20, NULL);
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('10', 8, '17', NULL, 18, 0, 20, NULL);
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('20', 10, 8, '20', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state, acc_type, credit_score FROM customer WHERE (no_of_loans <= 0) ORDER BY state, customer.cust_id NULLS LAST;

/*
Gold Result:
(None, None, 20)
(None, None, 20)
*/

-- Prediction Query
SELECT state, acc_type, credit_score FROM customer WHERE no_of_loans = 0;

/*
Prediction Result:
(None, None, 20)
*/