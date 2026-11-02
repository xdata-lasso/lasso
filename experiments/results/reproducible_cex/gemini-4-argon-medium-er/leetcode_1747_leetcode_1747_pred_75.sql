-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2020-01-01', NULL);
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, '2020-01-02', '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ACCOUNT_ID FROM (SELECT L1.ACCOUNT_ID, CASE WHEN L1.LOGOUT < L2.LOGIN THEN 0 ELSE 1 END AS BANNED FROM LOGINFO AS L1 CROSS JOIN LOGINFO AS L2 WHERE L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND L1.LOGIN <= L2.LOGIN) AS SUB WHERE BANNED = 1;

/*
Prediction Result:
(1,)
*/