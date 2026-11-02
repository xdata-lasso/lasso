-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
-- Tests NULL handling and single-session accounts to kill mutants using outer joins, COUNT(*) > 1 groupings without proper filtering, or improper NULL logic.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (99, 1, '2023-10-01 10:00:00', '2023-10-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (88, NULL, '2023-10-01 10:00:00', '2023-10-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (88, 2, '2023-10-01 11:00:00', '2023-10-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (NULL, 1, '2023-10-01 10:00:00', '2023-10-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (NULL, 2, '2023-10-01 11:00:00', '2023-10-01 13:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE_LOG AS (SELECT ACCOUNT_ID, LOGIN AS LOG_TIME, 'LOGIN' AS LOG_TYPE, IP_ADDRESS FROM LOGINFO UNION SELECT ACCOUNT_ID, LOGOUT AS LOG_TIME, 'LOGOUT' AS LOG_TYPE, IP_ADDRESS FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM (SELECT ACCOUNT_ID, IP_ADDRESS AS CURRENT_ADDRESS, LOG_TYPE AS CURRENT_LOG_TYPE, LEAD(LOG_TYPE, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOG_TIME) AS NEXT_LOG_TYPE, LEAD(IP_ADDRESS, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOG_TIME) AS NEXT_ADRESS FROM CTE_LOG) AS L WHERE CURRENT_LOG_TYPE = NEXT_LOG_TYPE AND CURRENT_ADDRESS <> NEXT_ADRESS;

/*
Prediction Result:
(None,)
*/