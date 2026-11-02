-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-02-01 09:00:00', '2021-02-01 11:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-02-01 10:00:00', '2021-02-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 10, '2021-02-01 08:00:00', '2021-02-01 10:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 20, '2021-02-01 09:30:00', '2021-02-01 11:30:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 30, '2021-02-01 08:00:00', '2021-02-01 09:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 40, '2021-02-01 10:00:00', '2021-02-01 11:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (4, 50, '2021-02-01 13:00:00', '2021-02-01 15:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (4, 60, '2021-02-01 15:00:00', '2021-02-01 17:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(2,)
(4,)
*/

-- Prediction Query
SELECT DISTINCT ACCOUNT_ID FROM (SELECT ACCOUNT_ID, IP_ADDRESS AS IP1, LOGOUT, LEAD(IP_ADDRESS) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS IP2, LEAD(LOGIN) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS LOGIN2, LOGOUT - LEAD(LOGIN) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS DIFF FROM LOGINFO) AS T WHERE T.DIFF >= 0 AND T.IP1 <> T.IP2;

/*
Prediction Result:
(2,)
(3,)
(4,)
*/