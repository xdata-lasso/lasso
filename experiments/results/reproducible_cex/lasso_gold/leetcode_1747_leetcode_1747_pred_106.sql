-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1036, '1993-02-01', '1993-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1037, '1993-02-01', '1994-03-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1037, '1993-01-31', '1993-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1038, 1039, '1995-04-02', '1995-04-04');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1038, 1040, '1995-04-03', '1996-05-04');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1042, '1997-06-05', '1997-06-06');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1043, '1997-06-04', '1998-07-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1035,)
(1038,)
(1041,)
*/

-- Prediction Query
WITH CTE AS (SELECT L1.*, L2.IP_ADDRESS AS OTHER_IP, L2.LOGIN AS OTHER_LOGIN, L2.LOGOUT AS OTHER_LOGOUT FROM LOGINFO AS L1 INNER JOIN LOGINFO AS L2 ON L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND DATE(L1.LOGIN) = DATE(L2.LOGIN)) SELECT DISTINCT ACCOUNT_ID FROM CTE WHERE OTHER_LOGIN BETWEEN LOGIN AND LOGOUT;

/*
Prediction Result:
(1035,)
*/