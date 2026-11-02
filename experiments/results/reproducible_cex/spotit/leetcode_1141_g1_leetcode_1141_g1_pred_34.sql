-- Schema DDL
CREATE TABLE "ACTIVITY" (
    "USER_ID" INT,
    "SESSION_ID" INT,
    "ACTIVITY_DATE" DATE,
    "ACTIVITY_TYPE" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ACTIVITY VALUES (0, 0, '2019-07-28', 5);
INSERT INTO ACTIVITY VALUES (0, 0, '2019-06-27', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
*/

-- Prediction Query
SELECT DAY, SUM(ACTIVE_USERS) AS ACTIVE_USERS FROM (SELECT ACTIVITY_DATE AS DAY, USER_ID, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE >= '2019-06-28' GROUP BY ACTIVITY_DATE, USER_ID) AS T GROUP BY DAY;

/*
Prediction Result:
('2019-07-28', 1)
*/