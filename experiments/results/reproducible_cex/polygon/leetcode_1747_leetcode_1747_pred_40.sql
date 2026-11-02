-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (27, 18, NULL, '1000-08-28');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (27, 16, '0998-06-30', '1000-08-28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT LI.ACCOUNT_ID FROM LOGINFO AS LI CROSS JOIN LOGINFO AS LG WHERE LI.ACCOUNT_ID = LG.ACCOUNT_ID AND (LG.LOGIN BETWEEN LI.LOGIN AND LI.LOGOUT OR LG.LOGOUT BETWEEN LI.LOGIN AND LI.LOGOUT) AND LI.IP_ADDRESS <> LG.IP_ADDRESS;

/*
Prediction Result:
(27,)
*/