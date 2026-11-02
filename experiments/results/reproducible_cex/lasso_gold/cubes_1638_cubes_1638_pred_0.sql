-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1001, 'Allison Hill', 1005, 'New Jamesside', 'Louisiana');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1002, 'Noah Rhodes', 1012.0, 'Robinsonshire', 'Georgia');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1003, 'Angie Henderson', 1019.0, 'Lisatown', 'Indiana');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1004, 'Daniel Wagner', 1026.0, 'Lake Roberto', 'Wisconsin');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('great', 1001, 'Ryan Munoz', 'participant', 1009, 1013, 1017, 'Arizona');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('blue', 1001, 'Monica Herrera', 'dark', 1020.0, 1026.0, 1032.0, 'Texas');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('best', 1001, 'Jamie Arnold', 'sea', 1031.0, 1039.0, 1047.0, 'Iowa');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('husband', 1001, 'Lisa Hensley', 'available', 1042.0, 1052.0, 1062.0, 'Wyoming');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name, acc_type, acc_bal FROM (SELECT * FROM (SELECT * FROM customer ORDER BY cust_name DESC, customer.cust_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Ryan Munoz', 'participant', 1009)
*/

-- Prediction Query
SELECT cust_name, acc_type, acc_bal FROM customer ORDER BY credit_score DESC, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Lisa Hensley', 'available', 1042)
*/