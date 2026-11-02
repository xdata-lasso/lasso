-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (20, 18, '0998-06-29', '0998-06-30');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (20, 19, '0998-06-30', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT DISTINCT LI.ACCOUNT_ID FROM LOGINFO AS LI LEFT JOIN LOGINFO AS DI ON LI.ACCOUNT_ID = DI.ACCOUNT_ID AND LI.IP_ADDRESS <> DI.IP_ADDRESS AND LI.LOGIN <= DI.LOGOUT AND LI.LOGOUT >= DI.LOGIN WHERE NOT DI.ACCOUNT_ID IS NULL;

/*
Prediction Result:
*/