-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 10
-- Tests exact identical intervals (I1.login == I2.login AND I1.logout == I2.logout) with different IPs, causing symmetric double matches in the join.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (10, 1, '2021-05-05 08:00:00', '2021-05-05 09:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (10, 2, '2021-05-05 08:00:00', '2021-05-05 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(10,)
*/

-- Prediction Query
WITH CTE AS (SELECT T1.ACCOUNT_ID, T1.IP_ADDRESS AS IP_ADDRESS1, T2.IP_ADDRESS AS IP_ADDRESS2, T1.LOGIN AS LOGIN1, T2.LOGIN AS LOGIN2, T1.LOGOUT AS LOGOUT1, T2.LOGOUT AS LOGOUT2 FROM LOGINFO AS T1 CROSS JOIN LOGINFO AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID WHERE (T1.LOGIN <> T2.LOGIN OR T1.LOGOUT <> T2.LOGOUT) AND T1.IP_ADDRESS < T2.IP_ADDRESS AND NOT (T1.LOGIN > T2.LOGOUT OR T2.LOGIN > T1.LOGOUT)) SELECT DISTINCT ACCOUNT_ID FROM CTE;

/*
Prediction Result:
*/