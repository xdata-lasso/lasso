-- Schema DDL
CREATE TABLE "I045" (
    "USER_ID" INT,
    "ACCOUNT_NO" INT,
    "ZIP" INT,
    "DATE" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I045 VALUES (0, 0, 0, 7);
INSERT INTO I045 VALUES (0, 0, NULL, 7);
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
(0, 2)
*/