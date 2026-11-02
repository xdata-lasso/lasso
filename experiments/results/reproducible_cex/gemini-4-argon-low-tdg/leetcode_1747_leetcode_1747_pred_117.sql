-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests interleaved sessions where an intermediate session has the SAME IP, ensuring mutants using LEAD/LAG partitioned only by account_id (ordered by login) fail if they only check adjacent rows.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (50, 1, '2023-08-01 08:00:00', '2023-08-01 15:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (50, 1, '2023-08-01 09:00:00', '2023-08-01 10:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (50, 2, '2023-08-01 11:00:00', '2023-08-01 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(50,)
*/

-- Prediction Query
WITH TEMP AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN ASC) AS LOGIN_RK FROM LOGINFO), TEMP1 AS (SELECT T1.ACCOUNT_ID, T1.IP_ADDRESS, T1.LOGIN, T1.LOGOUT, T2.IP_ADDRESS AS LAST_IP_ADDRESS, T2.LOGOUT AS LAST_LOGOUT FROM TEMP AS T1 LEFT JOIN TEMP AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID AND T1.LOGIN_RK - 1 = T2.LOGIN_RK) SELECT DISTINCT ACCOUNT_ID FROM TEMP1 WHERE LOGIN <= LAST_LOGOUT AND IP_ADDRESS <> LAST_IP_ADDRESS;

/*
Prediction Result:
*/