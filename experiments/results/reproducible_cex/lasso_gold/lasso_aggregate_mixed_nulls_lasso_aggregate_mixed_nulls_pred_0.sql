-- Schema DDL
CREATE TABLE USERS (USER_ID INTEGER PRIMARY KEY, NAME TEXT(50));

CREATE TABLE LOGINS (USER_ID INTEGER, LOGIN_DATE DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "logins" ("user_id", "login_date") VALUES (1004, '2022-07-02');
INSERT INTO "logins" ("user_id", "login_date") VALUES (1005, NULL);
INSERT INTO "logins" ("user_id", "login_date") VALUES (1005, '2022-07-02');
INSERT INTO "users" ("user_id", "name") VALUES (1004, 'Daniel Wagner');
INSERT INTO "users" ("user_id", "name") VALUES (1005, 'Cristian Santos');
INSERT INTO "users" ("user_id", "name") VALUES (1006, 'Connie Lawrence');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT U.USER_ID, U.NAME FROM USERS AS U INNER JOIN (SELECT USER_ID FROM LOGINS GROUP BY USER_ID HAVING MIN(LOGIN_DATE) >= '2022-01-01' AND MAX(LOGIN_DATE) <= '2022-12-31') AS L ON U.USER_ID = L.USER_ID;

/*
Gold Result:
(1004, 'Daniel Wagner')
(1005, 'Cristian Santos')
*/

-- Prediction Query
SELECT U.USER_ID, U.NAME FROM USERS AS U JOIN LOGINS AS L ON U.USER_ID = L.USER_ID GROUP BY U.USER_ID HAVING SUM(IIF(LOGIN_DATE BETWEEN '2022-01-01' AND '2022-12-31', 0, 1)) = 0;

/*
Prediction Result:
(1004, 'Daniel Wagner')
*/