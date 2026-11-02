-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO loginfo (account_id, ip_address, login, logout) VALUES (0, NULL, '2023-01-01', '2023-01-02'), (NULL, NULL, '2023-01-01', NULL), (1, 0, NULL, '2023-01-02'), (0, 0, '2023-01-02', NULL), (NULL, 0, '2023-01-02', NULL), (1, 1, '2023-01-01', NULL), (1, 0, '2023-01-01', NULL), (1, 0, NULL, '2023-01-01'), (NULL, NULL, '2023-01-02', NULL), (1, 1, '2023-01-02', NULL), (NULL, NULL, '2023-01-01', NULL), (1, 1, '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT T1.ACCOUNT_ID FROM LOGINFO AS T1 JOIN LOGINFO AS T2 ON (T1.ACCOUNT_ID = T2.ACCOUNT_ID) AND (T1.IP_ADDRESS <> T2.IP_ADDRESS) AND (T1.LOGIN <= T2.LOGOUT AND T1.LOGOUT >= T2.LOGIN);

/*
Prediction Result:
*/