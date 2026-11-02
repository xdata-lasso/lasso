-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
-- Tests NULL handling in columns to kill mutants using IS NOT NULL or improper join logic.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, NULL, '2021-01-01 10:00:00', '2021-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 102, '2021-01-01 11:00:00', '2021-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (NULL, 101, '2021-01-01 10:00:00', '2021-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (NULL, 102, '2021-01-01 11:00:00', '2021-01-01 13:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT (ACCOUNT_ID) FROM (SELECT ACCOUNT_ID, LOGOUT, IP_ADDRESS, LEAD(LOGIN, 1, '9999-12-31') OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_LOGIN, LEAD(IP_ADDRESS, 1, 0) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_IP_ADDRESS FROM LOGINFO) AS A WHERE LOGOUT >= NEXT_LOGIN AND IP_ADDRESS <> NEXT_IP_ADDRESS;

/*
Prediction Result:
(None,)
*/