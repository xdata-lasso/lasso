-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard partial overlap vs no overlap vs overlap with same IP vs overlap across different accounts.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 10, '2023-01-01 10:00:00', '2023-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 20, '2023-01-01 11:00:00', '2023-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 10, '2023-01-01 10:00:00', '2023-01-01 11:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 20, '2023-01-01 12:00:00', '2023-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 10, '2023-01-01 10:00:00', '2023-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 10, '2023-01-01 11:00:00', '2023-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (4, 10, '2023-01-01 10:00:00', '2023-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (5, 20, '2023-01-01 11:00:00', '2023-01-01 13:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH TMP2 AS (SELECT T1.ACCOUNT_ID, T1.IP_ADDRESS, T1.LOGOUT, T2.LOGIN, CASE WHEN T1.LOGIN < T2.LOGIN AND T1.LOGOUT < T2.LOGIN THEN 'NOT BANNED ELSE BANNED' END AS LABEL FROM LOGINFO AS T1 LEFT JOIN LOGINFO AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID AND T1.IP_ADDRESS <> T2.IP_ADDRESS AND T1.LOGIN < T2.LOGIN WHERE T2.LOGIN <= T1.LOGOUT) SELECT DISTINCT ACCOUNT_ID FROM TMP2 WHERE LABEL = 'BANNED';

/*
Prediction Result:
*/