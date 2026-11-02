-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO loginfo (account_id, ip_address, login, logout) VALUES (2, 0, NULL, '2023-01-02'), (1, NULL, NULL, '2023-01-02'), (0, 2, '2023-01-01', '2023-01-02'), (2, 0, NULL, '2023-01-01'), (0, 1, '2023-01-02', NULL), (2, 1, NULL, '2023-01-02'), (NULL, 1, '2023-01-01', NULL), (NULL, 0, '2023-01-01', '2023-01-02'), (1, 1, NULL, NULL), (0, 2, '2023-01-01', NULL), (0, 0, '2023-01-02', NULL), (2, 1, NULL, '2023-01-02'), (NULL, 0, '2023-01-02', NULL), (0, 2, '2023-01-01', '2023-01-02'), (1, 0, NULL, '2023-01-01'), (NULL, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT L1.ACCOUNT_ID FROM LOGINFO AS L1 JOIN LOGINFO AS L2 ON L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND L2.LOGIN <= L1.LOGOUT AND L2.LOGOUT >= L1.LOGIN GROUP BY 1;

/*
Prediction Result:
*/