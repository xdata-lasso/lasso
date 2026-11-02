-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1048, '1986-06-17', '1986-06-18');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1049, '1986-06-17', '1986-06-18');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1049, '1986-06-17', '1986-06-16');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1068, 1069, '1993-02-01', '1993-01-31');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1068, 1070, '1993-02-01', '1993-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1071, 1072, '1994-03-02', '1994-03-03');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1071, 1073, '1994-03-02', '1994-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1047,)
(1068,)
(1071,)
*/

-- Prediction Query
WITH LOG AS (SELECT ACCOUNT_ID, IP_ADDRESS, LOGIN, LOGOUT, ROW_NUMBER() OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS ROW1 FROM LOGINFO), LOG_MAP AS (SELECT A.ACCOUNT_ID, A.IP_ADDRESS, A.LOGIN, A.LOGOUT, A.ROW1, B.IP_ADDRESS AS L_IP, B.ROW1 AS L_ROW, B.LOGIN AS L_LOGIN, B.LOGOUT AS L_LOGOUT FROM LOG AS A LEFT JOIN LOG AS B ON A.ACCOUNT_ID = B.ACCOUNT_ID AND A.ROW1 = B.ROW1 - 1), FIAL_MAP AS (SELECT *, CASE WHEN LOGOUT >= L_LOGIN AND IP_ADDRESS <> L_IP THEN 1 ELSE 0 END AS BANNED FROM LOG_MAP), F_S AS (SELECT ACCOUNT_ID, SUM(BANNED) AS BANNED FROM FIAL_MAP GROUP BY ACCOUNT_ID) SELECT ACCOUNT_ID FROM F_S WHERE BANNED >= 1;

/*
Prediction Result:
(1047,)
(1071,)
*/