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
SELECT DISTINCT ACCOUNT_ID FROM (SELECT A.*, CASE WHEN NEXT_LOGIN >= LOGIN AND NEXT_LOGIN <= LOGOUT AND IP_ADDRESS <> NEXT_IP_ADDRESS THEN 1 ELSE 0 END AS FLAG FROM (SELECT A.*, LEAD(IP_ADDRESS) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_IP_ADDRESS, LEAD(LOGIN) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_LOGIN FROM LOGINFO AS A) AS A WHERE NOT NEXT_LOGIN IS NULL) AS A WHERE FLAG = 1;

/*
Prediction Result:
(None,)
*/