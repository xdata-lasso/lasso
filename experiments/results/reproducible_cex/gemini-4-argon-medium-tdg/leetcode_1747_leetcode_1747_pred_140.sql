-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests boundary condition: I2.login == I1.login (inclusive lower bound of BETWEEN).
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 101, '2021-01-01 10:00:00', '2021-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 102, '2021-01-01 10:00:00', '2021-01-01 11:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT L.ACCOUNT_ID FROM LOGINFO AS L JOIN LOGINFO AS I ON L.ACCOUNT_ID = I.ACCOUNT_ID AND ((I.LOGIN BETWEEN L.LOGIN AND L.LOGOUT) OR (I.LOGOUT BETWEEN L.LOGIN AND L.LOGOUT)) AND I.LOGIN <> L.LOGIN AND I.LOGOUT <> L.LOGOUT AND I.IP_ADDRESS <> L.IP_ADDRESS;

/*
Prediction Result:
*/