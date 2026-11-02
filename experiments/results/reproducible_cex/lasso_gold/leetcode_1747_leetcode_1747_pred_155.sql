-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1001, 1002, '1970-01-01', '1971-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1001, 1003, '1971-02-01', '1970-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT DISTINCT L1.ACCOUNT_ID FROM LOGINFO AS L1 INNER JOIN LOGINFO AS L2 ON L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND MAX(L1.LOGIN, L2.LOGIN) <= MIN(L1.LOGOUT, L2.LOGOUT);

/*
Prediction Result:
*/