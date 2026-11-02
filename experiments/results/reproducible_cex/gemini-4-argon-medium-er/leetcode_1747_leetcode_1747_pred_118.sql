-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, '2020-01-01', '2020-01-05');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2020-01-02', NULL);
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (2, 1, '2020-01-02', '2020-01-05');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (2, 2, '2020-01-03', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
WITH TEMP AS (SELECT A.ACCOUNT_ID, SUM(IIF(B.LOGOUT >= A.LOGIN AND B.LOGIN <= A.LOGOUT, 1, 0)) AS TWO_IP_COUNT FROM LOGINFO AS A CROSS JOIN LOGINFO AS B WHERE A.ACCOUNT_ID = B.ACCOUNT_ID AND A.IP_ADDRESS <> B.IP_ADDRESS GROUP BY A.ACCOUNT_ID) SELECT ACCOUNT_ID FROM TEMP WHERE TWO_IP_COUNT > 0;

/*
Prediction Result:
*/