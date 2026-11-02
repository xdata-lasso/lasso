-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1049, 'Kimberly Adams', 1052, 'Teresaburgh', 'Hawaii');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1050, 'Ashley Graham', 1059.0, 'Port Colleenhaven', 'Ohio');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1051, 'Troy Liu', 1066.0, 'East Nathaniel', 'Wyoming');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1073, 'Jessica Holmes', 1076, 'Lake Crystalbury', 'Indiana');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1074, 'Danny Morgan', 1083.0, 'North Micheleland', 'Florida');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1075, 'Crystal Robinson', 1090.0, 'West Elizabeth', 'Oregon');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('win', 1049, 'Fred Smith', 'your', 1055, 1058, 1061, 'Washington');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('nice', 1049, 'Sherry Decker', 'bar', 1066.0, 1071.0, 1076.0, 'New York');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('why', 1049, 'Anthony Humphrey', 'bed', 1077.0, 1084.0, 1091.0, 'California');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('soon', 1049, 'Matthew Arroyo', 'road', 1064, 1067, 1070, 'Maryland');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('no', 1049, 'Joseph Obrien', 'deep', 1075.0, 1080.0, 1085.0, 'Montana');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('space', 1049, 'Tanya Campos', 'sell', 1086.0, 1093.0, 1100.0, 'Texas');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('part', 1073, 'Rhonda Lee', 'race', 1079, 1082, NULL, 'Michigan');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('material', 1073, 'Jeffrey Henderson', 'billion', 1090.0, 1095.0, NULL, 'Connecticut');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('eight', 1073, 'Nicholas Nunez', 'ask', 1101.0, 1108.0, NULL, 'Kansas');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('dark', 1073, 'Javier Ramirez', 'now', 1088, 1091, NULL, 'Colorado');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('customer', 1073, 'Thomas Ramos', 'think', 1099.0, 1104.0, NULL, 'Wisconsin');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('not', 1073, 'Krista Williams', 'administration', 1110.0, 1117.0, NULL, 'Nebraska');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cust_name FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, LHS.mincredit_score AS mincredit_score, RHS.cust_id AS cust_id_other, RHS.cust_name AS cust_name_other, RHS.acc_type AS acc_type_other, RHS.acc_bal AS acc_bal_other, RHS.no_of_loans AS no_of_loans_other, RHS.credit_score AS credit_score_other, RHS.branch_id AS branch_id_other, RHS.state AS state_other, RHS.mincredit_score AS mincredit_score_other FROM (SELECT cust_id, cust_name, acc_type, acc_bal, no_of_loans, credit_score, branch_id, state, MIN(credit_score) OVER () AS mincredit_score FROM customer) AS LHS CROSS JOIN (SELECT cust_id, cust_name, acc_type, acc_bal, no_of_loans, credit_score, branch_id, state, MIN(credit_score) OVER () AS mincredit_score FROM customer) AS RHS) WHERE (credit_score = mincredit_score_other OR credit_score_other < mincredit_score_other) ORDER BY cust_name;

/*
Gold Result:
('Fred Smith',)
*/

-- Prediction Query
SELECT cust_name FROM customer ORDER BY credit_score, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Thomas Ramos',)
*/