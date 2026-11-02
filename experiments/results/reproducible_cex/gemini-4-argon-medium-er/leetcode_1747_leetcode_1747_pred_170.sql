-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, '2020-01-01', '2020-01-05');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2020-01-06', '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT LO1.ACCOUNT_ID FROM LOGINFO AS LO1 JOIN LOGINFO AS LO2 ON LO1.ACCOUNT_ID = LO2.ACCOUNT_ID AND LO1.IP_ADDRESS <> LO2.IP_ADDRESS AND ((LO1.LOGOUT BETWEEN LO2.LOGIN AND LO2.LOGOUT) OR (LO2.LOGOUT BETWEEN LO1.LOGIN AND LO1.LOGOUT));

/*
Prediction Result:
(1,)
*/