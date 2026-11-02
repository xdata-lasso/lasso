-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 15, '1000-08-27', NULL);
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 16, '1000-08-27', '1000-08-28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT DISTINCT L.ACCOUNT_ID FROM LOGINFO AS L JOIN LOGINFO AS I ON L.ACCOUNT_ID = I.ACCOUNT_ID AND ((I.LOGIN BETWEEN L.LOGIN AND L.LOGOUT) OR (I.LOGOUT BETWEEN L.LOGIN AND L.LOGOUT)) AND I.LOGIN <> L.LOGIN AND I.LOGOUT <> L.LOGOUT AND I.IP_ADDRESS <> L.IP_ADDRESS;

/*
Prediction Result:
*/