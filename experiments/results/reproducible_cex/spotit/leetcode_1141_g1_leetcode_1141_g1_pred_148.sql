-- Schema DDL
CREATE TABLE "ACTIVITY" (
    "USER_ID" INT,
    "SESSION_ID" INT,
    "ACTIVITY_DATE" DATE,
    "ACTIVITY_TYPE" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ACTIVITY VALUES (1, 0, '2019-07-28', 7);
INSERT INTO ACTIVITY VALUES (0, 0, '2019-07-28', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY GROUP BY ACTIVITY_DATE HAVING ACTIVITY_DATE >= '2019-06-28' AND ACTIVITY_DATE <= '2019-08-24';

/*
Prediction Result:
('2019-07-28', 2)
*/