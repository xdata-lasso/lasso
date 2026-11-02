-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 15, NULL, '1000-08-28');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 16, '1000-08-27', '1000-08-28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.ACCOUNT_ID FROM LOGINFO AS T1 JOIN LOGINFO AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID AND T1.IP_ADDRESS <> T2.IP_ADDRESS AND (T2.LOGIN BETWEEN T1.LOGIN AND T1.LOGOUT OR T2.LOGOUT BETWEEN T1.LOGIN AND T1.LOGOUT);

/*
Prediction Result:
(18,)
*/