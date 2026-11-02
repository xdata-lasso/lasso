-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (21, 18, '1000-08-27', NULL);
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (21, 19, '0998-06-30', '1000-08-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(21,)
*/

-- Prediction Query
SELECT DISTINCT ACCOUNT_ID FROM (SELECT LOG1.ACCOUNT_ID, LOG1.IP_ADDRESS AS IP1, LOG2.IP_ADDRESS AS IP2 FROM LOGINFO AS LOG1 JOIN LOGINFO AS LOG2 ON LOG1.ACCOUNT_ID = LOG2.ACCOUNT_ID WHERE LOG1.LOGIN <= LOG2.LOGOUT AND LOG2.LOGIN <= LOG1.LOGOUT) AS T WHERE IP1 <> IP2;

/*
Prediction Result:
*/