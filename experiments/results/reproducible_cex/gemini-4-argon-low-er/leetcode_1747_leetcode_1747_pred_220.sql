-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 10, '2020-01-02', NULL);
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 20, '2020-01-01', '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT L1.ACCOUNT_ID FROM LOGINFO AS L1 LEFT JOIN LOGINFO AS L2 ON L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND NOT (L1.LOGOUT < L2.LOGIN OR L2.LOGOUT < L1.LOGIN) WHERE NOT L2.ACCOUNT_ID IS NULL;

/*
Prediction Result:
*/