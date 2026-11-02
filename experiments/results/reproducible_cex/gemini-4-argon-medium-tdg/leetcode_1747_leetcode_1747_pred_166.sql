-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
-- Tests non-overlapping disjoint intervals for the same account with different IPs.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 101, '2021-01-01 10:00:00', '2021-01-01 11:59:59');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 102, '2021-01-01 12:00:00', '2021-01-01 14:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACCOUNT_ID AS ACCOUNT_ID FROM LOGINFO AS A JOIN LOGINFO AS B ON A.ACCOUNT_ID = B.ACCOUNT_ID WHERE A.IP_ADDRESS <> B.IP_ADDRESS AND (A.LOGOUT - B.LOGIN) * (B.LOGOUT - A.LOGIN) >= 0 GROUP BY A.ACCOUNT_ID;

/*
Prediction Result:
(1,)
*/