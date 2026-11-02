-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-01-01', '2021-01-10');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-01-02', '2021-01-03');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, '2021-01-05', '2021-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT *, LEAD(LOGIN) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_LOGIN, LEAD(IP_ADDRESS) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_IP FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM CTE WHERE LOGOUT >= NEXT_LOGIN AND NEXT_IP <> IP_ADDRESS;

/*
Prediction Result:
*/