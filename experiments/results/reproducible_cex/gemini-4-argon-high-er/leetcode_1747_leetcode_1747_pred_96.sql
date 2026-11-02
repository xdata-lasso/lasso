-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-01-01', '2021-01-05');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, '2021-01-02', NULL);
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 1, '2021-01-01', '2021-01-05');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 2, '2021-01-10', '2021-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT LGIF.ACCOUNT_ID FROM LOGINFO AS LGIF JOIN LOGINFO AS LGIF2 ON LGIF.ACCOUNT_ID = LGIF2.ACCOUNT_ID AND LGIF.IP_ADDRESS <> LGIF2.IP_ADDRESS AND ((LGIF.LOGIN <= LGIF2.LOGIN AND LGIF.LOGOUT >= LGIF2.LOGIN AND LGIF.LOGOUT <= LGIF2.LOGOUT) OR (LGIF.LOGIN <= LGIF2.LOGIN AND LGIF2.LOGOUT <= LGIF.LOGOUT));

/*
Prediction Result:
(2,)
*/