-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-04-01 08:00:00', '2021-04-01 09:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, '2021-04-01 10:00:00', '2021-04-01 11:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 3, '2021-04-01 08:00:00', '2021-04-01 10:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 4, '2021-04-02 08:30:00', '2021-04-02 09:30:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 5, '2021-04-01 23:00:00', '2021-04-02 01:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (3, 6, '2021-04-02 00:30:00', '2021-04-02 02:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT DISTINCT A.ACCOUNT_ID FROM LOGINFO AS A CROSS JOIN LOGINFO AS B WHERE DATE(A.LOGIN) = DATE(B.LOGIN) AND B.LOGIN BETWEEN A.LOGIN AND A.LOGOUT AND A.ACCOUNT_ID = B.ACCOUNT_ID AND A.IP_ADDRESS <> B.IP_ADDRESS;

/*
Prediction Result:
*/