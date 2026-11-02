-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (10, 100, '2021-06-01 08:00:00', '2021-06-01 09:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (10, 200, '2021-06-01 08:00:00', '2021-06-01 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT DISTINCT T1.ACCOUNT_ID FROM LOGINFO AS T1 CROSS JOIN LOGINFO AS T2 WHERE T1.ACCOUNT_ID = T2.ACCOUNT_ID AND T1.IP_ADDRESS <> T2.IP_ADDRESS AND T1.LOGIN < T2.LOGIN AND T1.LOGOUT >= T2.LOGIN;

/*
Prediction Result:
*/