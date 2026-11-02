-- Schema DDL
CREATE TABLE "i045" ("user_id" INTEGER, "account_no" INTEGER, "zip" INTEGER, "date" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i045 (user_id, account_no, zip, date) VALUES (1, 10, 100, '2023-01-01');
INSERT INTO i045 (user_id, account_no, zip, date) VALUES (2, 10, 100, '2023-01-02');
INSERT INTO i045 (user_id, account_no, zip, date) VALUES (2, 20, 200, '2023-01-02');
INSERT INTO i045 (user_id, account_no, zip, date) VALUES (3, 30, 300, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT user_id, user_id_other AS n FROM (SELECT LHS.date AS date, LHS.user_id AS user_id, LHS.n AS n, RHS.date AS date_other, RHS.user_id AS user_id_other, RHS.n AS n_other FROM (SELECT date, user_id, COUNT(*) AS n FROM i045 GROUP BY date, user_id) AS LHS CROSS JOIN (SELECT date, user_id, COUNT(*) AS n FROM i045 GROUP BY date, user_id) AS RHS) WHERE (n < n_other) ORDER BY user_id, n NULLS LAST;

/*
Gold Result:
(1, 2)
(3, 2)
*/

-- Prediction Query
SELECT user_id, COUNT(*) FROM (SELECT DISTINCT user_id, account_no, zip, date FROM i045) AS payment GROUP BY user_id, account_no, date HAVING COUNT(*) > 1;

/*
Prediction Result:
*/