-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests inclusive boundary conditions of BETWEEN: exact match on I1.LOGIN == I2.LOGIN, and exact match on I2.LOGIN == I1.LOGOUT.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (10, 1, '2023-05-01 08:00:00', '2023-05-01 10:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (10, 2, '2023-05-01 10:00:00', '2023-05-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (20, 1, '2023-05-01 08:00:00', '2023-05-01 10:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (20, 2, '2023-05-01 08:00:00', '2023-05-01 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT DISTINCT L.ACCOUNT_ID FROM LOGINFO AS L JOIN LOGINFO AS I ON L.ACCOUNT_ID = I.ACCOUNT_ID AND ((I.LOGIN BETWEEN L.LOGIN AND L.LOGOUT) OR (I.LOGOUT BETWEEN L.LOGIN AND L.LOGOUT)) AND I.LOGIN <> L.LOGIN AND I.LOGOUT <> L.LOGOUT AND I.IP_ADDRESS <> L.IP_ADDRESS;

/*
Prediction Result:
(10,)
*/