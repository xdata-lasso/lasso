-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, '2020-01-01', '2020-01-02');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, NULL, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT X.ACCOUNT_ID FROM LOGINFO AS X CROSS JOIN LOGINFO AS Y WHERE X.ACCOUNT_ID = Y.ACCOUNT_ID AND X.IP_ADDRESS <> Y.IP_ADDRESS AND (Y.LOGIN BETWEEN X.LOGIN AND X.LOGOUT OR Y.LOGOUT BETWEEN X.LOGIN AND X.LOGOUT);

/*
Prediction Result:
(1,)
*/