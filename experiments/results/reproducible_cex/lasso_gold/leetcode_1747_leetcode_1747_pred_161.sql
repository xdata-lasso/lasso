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
SELECT DISTINCT A.ACCOUNT_ID FROM LOGINFO AS A CROSS JOIN LOGINFO AS B WHERE DATE(A.LOGIN) = DATE(B.LOGIN) AND B.LOGIN BETWEEN A.LOGIN AND A.LOGOUT AND A.ACCOUNT_ID = B.ACCOUNT_ID AND A.IP_ADDRESS <> B.IP_ADDRESS;

/*
Prediction Result:
(1035,)
*/