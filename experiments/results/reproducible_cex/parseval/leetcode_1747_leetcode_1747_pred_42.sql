-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: loginfo --
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, -55602865, '2025-06-13', '2023-03-15');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, -664303813, '2022-12-08', '2020-06-07');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, -1726781632, '2021-12-04', '2022-04-27');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, -1980249628, '2022-10-19', '2021-02-11');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (NULL, 809183447, '2025-11-03', '2023-09-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE_LOG AS (SELECT ACCOUNT_ID, LOGIN AS LOG_TIME, 'LOGIN' AS LOG_TYPE, IP_ADDRESS FROM LOGINFO UNION SELECT ACCOUNT_ID, LOGOUT AS LOG_TIME, 'LOGOUT' AS LOG_TYPE, IP_ADDRESS FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM (SELECT ACCOUNT_ID, IP_ADDRESS AS CURRENT_ADDRESS, LOG_TYPE AS CURRENT_LOG_TYPE, LEAD(LOG_TYPE, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOG_TIME) AS NEXT_LOG_TYPE, LEAD(IP_ADDRESS, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOG_TIME) AS NEXT_ADRESS FROM CTE_LOG) AS L WHERE CURRENT_LOG_TYPE = NEXT_LOG_TYPE AND CURRENT_ADDRESS <> NEXT_ADRESS;

/*
Prediction Result:
(1,)
*/