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
WITH NETF AS (SELECT DISTINCT L1.ACCOUNT_ID, L1.IP_ADDRESS, LEAD(L1.IP_ADDRESS) OVER (PARTITION BY L1.ACCOUNT_ID ORDER BY L1.LOGIN) AS LEAD_IP, L1.LOGIN, LEAD(L1.LOGIN) OVER (PARTITION BY L1.ACCOUNT_ID ORDER BY L1.LOGIN) AS LEADLOG, L1.LOGOUT, LEAD(L1.LOGOUT) OVER (PARTITION BY L1.ACCOUNT_ID ORDER BY L1.LOGIN) AS LEADLOGOUT FROM LOGINFO AS L1) SELECT DISTINCT ACCOUNT_ID FROM NETF WHERE LEADLOG BETWEEN LOGIN AND LOGOUT AND IP_ADDRESS <> LEAD_IP;

/*
Prediction Result:
*/