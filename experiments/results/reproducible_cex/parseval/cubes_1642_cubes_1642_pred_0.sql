-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (-2147483648, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_1', -2147483648, 'cus_bb8874', '1', -59984348, -664303813, -1022641847, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('t1__eb2d15', -2147483648, 't1__ca32b2', 'value', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('O', -2147483648, 'cus_bb8874', '1', 1610062532, -106629402, 1871297066, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('A', -2147483648, 'cus_bb8874', '1', 89267185, -1865039888, 1160656988, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('t1__b43aee', -2147483648, 't1__ca89bf', 'value', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_6', -2147483648, 'cus_bb8874', '1', 1115440883, 1644814318, 1465859724, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_7', -2147483648, 'cus_b617c8', '1', 700293388, 906324270, 1908028688, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_8', -2147483648, 'cus_bb8874', '1', -1910425938, -845863578, -1610064545, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_', -2147483648, 'cus_47fcee', '1', 462974032, -1137908826, -918961358, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_10', -2147483648, 'cus_bb8874', '1', -45536098, 1861536320, 44952191, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_11', -2147483648, 'cus_bb8874', '1', 1419861592, 700088193, 374105386, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_12', -2147483648, 'cus_bb8874', '1', -1833165707, 1155439218, 1313172851, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_13', -2147483648, 'cus_bb8874', '1', 742285925, -747753377, 902887186, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('t2__daa1fd', -2147483648, 't1__ca32b2', 'value', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_15', -2147483648, 'cus_bb8874', '1', 373262291, -472966518, -921187550, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_16', -2147483648, 'cus_bb8874', '1', 743312762, -1822992503, -868774469, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_17', -2147483648, 'cus_bb8874', '1', 2074205376, 274769912, -188151580, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_18', -2147483648, 'cus_bb8874', '1', -1390245819, 1055976837, 1775126557, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_19', -2147483648, NULL, '1', -453362185, 481163439, 2123196517, 'cus_2653a8');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value', 't1__eb2d15', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('l_2', 't1__eb2d15', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1', 't1__eb2d15', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('l_4', 't1__eb2d15', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2', 't1__eb2d15', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3', '_', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4', 'O', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5', 'O', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6', '_', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('_', 't2__daa1fd', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('A', 't2__daa1fd', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('O', 't2__daa1fd', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('G', 't2__daa1fd', '-2147483648', 'Mortgages', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7', 't1__eb2d15', '-2147483648', 't2__ad6fea', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8', 't1__eb2d15', '-2147483648', 'Mortgages', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cust_name" FROM (SELECT "cust_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "branch_id", "state", "loan_type", "cust_id_other", "branch_id_other", "amount", "cust_id" AS "loan_id" FROM (SELECT "LHS"."cust_id" AS "cust_id", "LHS"."cust_name" AS "cust_name", "LHS"."acc_type" AS "acc_type", "LHS"."acc_bal" AS "acc_bal", "LHS"."no_of_loans" AS "no_of_loans", "LHS"."credit_score" AS "credit_score", "LHS"."branch_id" AS "branch_id", "LHS"."state" AS "state", "RHS"."loan_type" AS "loan_type", "RHS"."cust_id" AS "cust_id_other", "RHS"."branch_id" AS "branch_id_other", "RHS"."amount" AS "amount" FROM "customer" AS "LHS" INNER JOIN "loan" AS "RHS" ON ("LHS"."cust_id" = "RHS"."loan_id"))) WHERE ("loan_type" <> 'Mortgages') ORDER BY cust_name, "cust_name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT cust_name FROM customer EXCEPT SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id WHERE T2.loan_type = 'Mortgages';

/*
Prediction Result:
(None,)
('cus_b617c8',)
('t1__ca89bf',)
*/