-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (NULL, 1057, '1978-05-15', '1978-05-16');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (NULL, 1058, '1978-05-15', '1979-06-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT ACCOUNT_ID, LOGIN <= LAG(LOGOUT, 1, '1970-01-01 00:00:00') OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS IND1, IP_ADDRESS <> LAG(IP_ADDRESS, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS IND2 FROM LOGINFO) SELECT ACCOUNT_ID FROM A WHERE IND1 = 1 AND IND2 = 1 GROUP BY 1;

/*
Prediction Result:
(None,)
*/