-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: loginfo --
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2024-06-15', '1991-02-19');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2024-06-15', '1969-12-31');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 1, '2024-06-15', '1970-01-01');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (-55602865, NULL, '2025-06-13', '2023-03-15');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2024-06-15', '1970-01-01');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (-664303813, -1022641847, NULL, '2021-02-05');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, NULL, '1970-01-01');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (-890215420, 1610062532, '2025-04-30', NULL);

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, '2024-06-15', NULL);

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (NULL, -734455130, '2020-09-26', '2025-06-04');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (NULL, 2, '2024-06-15', '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT ACCOUNT_ID, IP_ADDRESS, LEAD(IP_ADDRESS, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN ASC) AS NEXT_IP_ADDRESS, LOGIN, LOGOUT, LEAD(LOGIN, 1) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN ASC) AS NEXT_LOGIN FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM CTE WHERE LOGOUT >= NEXT_LOGIN AND IP_ADDRESS <> NEXT_IP_ADDRESS;

/*
Prediction Result:
(None,)
*/