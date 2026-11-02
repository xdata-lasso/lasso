-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 15, '1000-08-27', NULL);
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (18, 16, '1000-08-27', '1002-10-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT DISTINCT T.ACCOUNT_ID FROM LOGINFO AS T JOIN LOGINFO AS TT ON T.ACCOUNT_ID = TT.ACCOUNT_ID AND T.LOGOUT >= TT.LOGIN AND T.IP_ADDRESS <> TT.IP_ADDRESS AND T.LOGIN <= TT.LOGOUT;

/*
Prediction Result:
*/