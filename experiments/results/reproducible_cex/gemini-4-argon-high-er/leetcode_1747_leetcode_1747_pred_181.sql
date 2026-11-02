-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2020-01-01', '2020-01-03');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, '2020-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT LI1.ACCOUNT_ID FROM LOGINFO AS LI1 CROSS JOIN LOGINFO AS LI2 WHERE LI1.ACCOUNT_ID = LI2.ACCOUNT_ID AND LI1.IP_ADDRESS <> LI2.IP_ADDRESS AND (LI1.LOGIN <= LI2.LOGOUT AND LI1.LOGOUT >= LI2.LOGIN);

/*
Prediction Result:
*/