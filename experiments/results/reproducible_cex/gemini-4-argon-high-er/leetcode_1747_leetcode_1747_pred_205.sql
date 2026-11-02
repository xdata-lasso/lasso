-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, '2021-01-01', '2021-01-10');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, '2021-01-02', '2021-01-03');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2021-01-05', '2021-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT A.ACCOUNT_ID FROM (SELECT ACCOUNT_ID, LOGIN, IP_ADDRESS, LEAD(LOGIN, 1, NULL) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN ASC) AS LD_LOGIN, LOGOUT, LEAD(IP_ADDRESS, 1, NULL) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN ASC) AS LD_IP FROM LOGINFO) AS A WHERE NOT A.LD_LOGIN IS NULL AND A.IP_ADDRESS <> A.LD_IP AND A.LD_LOGIN BETWEEN A.LOGIN AND A.LOGOUT;

/*
Prediction Result:
*/