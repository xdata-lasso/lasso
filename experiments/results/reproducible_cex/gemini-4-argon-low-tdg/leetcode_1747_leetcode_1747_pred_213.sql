-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard partial overlap vs no overlap vs overlap with same IP vs overlap across different accounts.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 10, '2023-01-01 10:00:00', '2023-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 20, '2023-01-01 11:00:00', '2023-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 10, '2023-01-01 10:00:00', '2023-01-01 11:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 20, '2023-01-01 12:00:00', '2023-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 10, '2023-01-01 10:00:00', '2023-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 10, '2023-01-01 11:00:00', '2023-01-01 13:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (4, 10, '2023-01-01 10:00:00', '2023-01-01 12:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (5, 20, '2023-01-01 11:00:00', '2023-01-01 13:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT A.ACCOUNT_ID FROM LOGINFO AS A JOIN LOGINFO AS B ON A.ACCOUNT_ID = B.ACCOUNT_ID AND A.IP_ADDRESS <> B.IP_ADDRESS AND A.LOGIN < B.LOGIN WHERE (A.LOGOUT - B.LOGIN) >= 0;

/*
Prediction Result:
(1,)
(2,)
*/