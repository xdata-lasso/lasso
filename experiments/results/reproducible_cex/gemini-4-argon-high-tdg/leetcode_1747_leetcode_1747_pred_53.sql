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
SELECT DISTINCT L1.ACCOUNT_ID FROM LOGINFO AS L1 JOIN LOGINFO AS L2 ON MIN(L1.LOGOUT, L2.LOGOUT) - MAX(L1.LOGIN, L2.LOGIN) >= 0 AND L1.IP_ADDRESS > L2.IP_ADDRESS AND L1.ACCOUNT_ID = L2.ACCOUNT_ID;

/*
Prediction Result:
(2,)
(3,)
(4,)
*/