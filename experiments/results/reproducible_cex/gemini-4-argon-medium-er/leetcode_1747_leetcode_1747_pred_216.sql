-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, NULL, '2020-01-02');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2020-01-01', '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT LI.ACCOUNT_ID FROM LOGINFO AS LI JOIN LOGINFO AS LI2 ON LI.ACCOUNT_ID = LI2.ACCOUNT_ID AND LI.IP_ADDRESS <> LI2.IP_ADDRESS AND (LI2.LOGIN BETWEEN LI.LOGIN AND LI.LOGOUT OR LI2.LOGOUT BETWEEN LI.LOGIN AND LI.LOGOUT);

/*
Prediction Result:
(1,)
*/