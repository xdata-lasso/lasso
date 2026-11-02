-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: loginfo --
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (-55602865, -59984348, NULL, '2023-11-15');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, 2, NULL, '2024-06-15');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, -55602865, '2025-06-13', '2023-03-15');

INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1, -664303813, '2022-12-08', '2020-06-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
WITH TMP AS (SELECT *, LAG(LOGOUT) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS LD, LAG(IP_ADDRESS) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS LD_IP FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM TMP WHERE LD >= LOGIN AND LD_IP <> IP_ADDRESS;

/*
Prediction Result:
(1,)
*/