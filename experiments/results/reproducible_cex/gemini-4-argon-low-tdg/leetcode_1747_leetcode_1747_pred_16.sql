-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests interleaved sessions where an intermediate session has the SAME IP, ensuring mutants using LEAD/LAG partitioned only by account_id (ordered by login) fail if they only check adjacent rows.
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (50, 1, '2023-08-01 08:00:00', '2023-08-01 15:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (50, 1, '2023-08-01 09:00:00', '2023-08-01 10:00:00');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (50, 2, '2023-08-01 11:00:00', '2023-08-01 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(50,)
*/

-- Prediction Query
SELECT DISTINCT ACCOUNT_ID FROM (SELECT *, LEAD(IP_ADDRESS, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_IP, LEAD(LOGIN, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_LOGIN FROM LOGINFO) AS T WHERE NEXT_LOGIN <= LOGOUT AND NEXT_IP <> IP_ADDRESS;

/*
Prediction Result:
*/