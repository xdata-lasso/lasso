-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO loginfo (account_id, ip_address, login, logout) VALUES (2, NULL, '2023-01-02', NULL), (1, 1, NULL, '2023-01-02'), (NULL, 2, '2023-01-02', NULL), (2, NULL, NULL, '2023-01-01'), (0, 2, '2023-01-01', NULL), (1, NULL, '2023-01-01', '2023-01-02'), (0, 1, '2023-01-01', '2023-01-02'), (2, 2, '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT A.ACCOUNT_ID FROM LOGINFO AS A JOIN LOGINFO AS B ON A.ACCOUNT_ID = B.ACCOUNT_ID AND A.IP_ADDRESS <> B.IP_ADDRESS WHERE A.LOGIN <= B.LOGOUT AND A.LOGIN > B.LOGIN GROUP BY 1;

/*
Prediction Result:
*/