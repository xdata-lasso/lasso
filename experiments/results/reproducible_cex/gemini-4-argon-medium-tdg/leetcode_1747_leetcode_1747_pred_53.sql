-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
-- Tests non-overlapping disjoint intervals for the same account with different IPs.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 101, '2021-01-01 10:00:00', '2021-01-01 11:59:59');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 102, '2021-01-01 12:00:00', '2021-01-01 14:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT L1.ACCOUNT_ID FROM LOGINFO AS L1 JOIN LOGINFO AS L2 ON MIN(L1.LOGOUT, L2.LOGOUT) - MAX(L1.LOGIN, L2.LOGIN) >= 0 AND L1.IP_ADDRESS > L2.IP_ADDRESS AND L1.ACCOUNT_ID = L2.ACCOUNT_ID;

/*
Prediction Result:
(1,)
*/