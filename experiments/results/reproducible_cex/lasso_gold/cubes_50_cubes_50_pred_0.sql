-- Schema DDL
CREATE TABLE "i045" ("user_id" INTEGER, "account_no" INTEGER, "zip" INTEGER, "date" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1015, 1016, 1019, 'ago');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1015, 1021.0, 1026.0, 'ago');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1015, 1026.0, 1033.0, 'ago');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1022, 1023, 1026, 'site');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1022, 1028.0, 1033.0, 'site');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1022, 1033.0, 1040.0, 'site');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1057, NULL, 1061, 'dog');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1057, NULL, 1068.0, 'dog');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1057, NULL, 1075.0, 'dog');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1064, NULL, 1068, 'chair');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1064, NULL, 1075.0, 'chair');
INSERT INTO "i045" ("user_id", "account_no", "zip", "date") VALUES (1064, NULL, 1082.0, 'chair');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, user_id_other AS n FROM (SELECT LHS.date AS date, LHS.user_id AS user_id, LHS.n AS n, RHS.date AS date_other, RHS.user_id AS user_id_other, RHS.n AS n_other FROM (SELECT date, user_id, COUNT(*) AS n FROM i045 GROUP BY date, user_id) AS LHS CROSS JOIN (SELECT date, user_id, COUNT(*) AS n FROM i045 GROUP BY date, user_id) AS RHS) WHERE (n < n_other) ORDER BY user_id, n NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT user_id, COUNT(*) FROM (SELECT DISTINCT user_id, account_no, zip, date FROM i045) AS payment GROUP BY user_id, account_no, date HAVING COUNT(*) > 1;

/*
Prediction Result:
(1057, 3)
(1064, 3)
*/