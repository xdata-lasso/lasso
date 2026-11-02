-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2021-01-01', '2021-01-02');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, NULL, '2021-01-01');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 1, '2021-01-01', '2021-01-02');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (2, 2, '2021-01-05', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT L.ACCOUNT_ID FROM LOGINFO AS L INNER JOIN LOGINFO AS L1 ON L.ACCOUNT_ID = L1.ACCOUNT_ID AND L.IP_ADDRESS <> L1.IP_ADDRESS WHERE (L1.LOGIN >= L.LOGIN AND L1.LOGIN <= L.LOGOUT) OR (L1.LOGOUT <= L.LOGIN AND L1.LOGOUT >= L.LOGIN) OR (L1.LOGIN <= L.LOGIN AND L1.LOGOUT >= L.LOGOUT);

/*
Prediction Result:
(1,)
(2,)
*/