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
WITH P AS (SELECT *, LEAD(LOGIN) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_LOGIN, LEAD(IP_ADDRESS, 1, -1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_IP FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM P WHERE NEXT_LOGIN <= LOGOUT AND NEXT_IP <> IP_ADDRESS;

/*
Prediction Result:
(None,)
*/