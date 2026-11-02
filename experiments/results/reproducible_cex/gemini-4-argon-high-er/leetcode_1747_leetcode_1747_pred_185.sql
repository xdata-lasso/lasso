-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2020-01-01', '2020-01-10');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2020-01-02', '2020-01-03');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, '2020-01-05', '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH TMP AS (SELECT *, LEAD(LOGIN, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS LEAD_LOGIN, LEAD(IP_ADDRESS, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS LEAD_ADDRESS FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM TMP WHERE LEAD_LOGIN <= LOGOUT AND IP_ADDRESS <> LEAD_ADDRESS;

/*
Prediction Result:
*/