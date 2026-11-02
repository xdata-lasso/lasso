-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 15, '1000-08-27', NULL);
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 16, '0998-06-30', '1000-08-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT DISTINCT T1.ACCOUNT_ID FROM LOGINFO AS T1 JOIN LOGINFO AS T2 ON (T1.ACCOUNT_ID = T2.ACCOUNT_ID) AND (T1.IP_ADDRESS <> T2.IP_ADDRESS) AND (T1.LOGIN <= T2.LOGOUT AND T1.LOGOUT >= T2.LOGIN);

/*
Prediction Result:
*/