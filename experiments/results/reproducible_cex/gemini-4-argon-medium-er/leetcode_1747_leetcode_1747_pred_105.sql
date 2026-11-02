-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 10, NULL, '2020-01-02');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 20, '2020-01-01', '2020-01-03');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (2, 10, '2020-01-05', '2020-01-02');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (2, 20, '2020-01-01', '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT T1.ACCOUNT_ID, T1.LOGIN AS IN1, T1.LOGOUT AS OU1, T2.LOGIN AS IN2, T2.LOGOUT AS OU2 FROM LOGINFO AS T1 JOIN LOGINFO AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID AND T1.IP_ADDRESS <> T2.IP_ADDRESS) SELECT DISTINCT ACCOUNT_ID FROM A WHERE (IN1 BETWEEN IN2 AND OU2) OR (OU1 BETWEEN IN2 AND OU2);

/*
Prediction Result:
(1,)
(2,)
*/