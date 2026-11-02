-- Schema DDL
CREATE TABLE DEPTS (DNAME TEXT(50), DPROJ INTEGER);

CREATE TABLE PAYROLL (EMPL INTEGER PRIMARY KEY, PDEPT TEXT(50));

CREATE TABLE TEAMS (TMEMBER INTEGER, TPROJ INTEGER, FOREIGN KEY (TMEMBER) REFERENCES PAYROLL (EMPL));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: payroll --
INSERT INTO "payroll" ("empl", "pdept") VALUES (1, 'pay_aacf51');

INSERT INTO "payroll" ("empl", "pdept") VALUES (-2147483647, 'pay_84e0c6');

INSERT INTO "payroll" ("empl", "pdept") VALUES (2, 'SECURITY');

-- Inserting into table: depts --
INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_d844b4', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('d_s_140e3b', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 2);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES (NULL, 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', 1);

INSERT INTO "depts" ("dname", "dproj") VALUES ('dep_ac2154', NULL);

INSERT INTO "depts" ("dname", "dproj") VALUES ('SECURITY', NULL);

-- Inserting into table: teams --
INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, NULL);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, NULL);

INSERT INTO "teams" ("tmember", "tproj") VALUES (2, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);

INSERT INTO "teams" ("tmember", "tproj") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT V1.E FROM (SELECT D.DNAME AS D, D.DPROJ AS P, P.EMPL AS E FROM DEPTS AS D CROSS JOIN PAYROLL AS P WHERE D.DNAME = P.PDEPT) AS V1 CROSS JOIN (SELECT T.TMEMBER AS E, P.PDEPT AS D, T.TPROJ AS P FROM TEAMS AS T CROSS JOIN PAYROLL AS P WHERE T.TMEMBER = P.EMPL) AS V2 WHERE V1.D = 'SECURITY' AND V1.P = V2.P AND V1.E = V2.E AND V1.D = V2.D;

/*
Gold Result:
(2,)
(2,)
(2,)
(2,)
(2,)
(2,)
(2,)
(2,)
(2,)
*/

-- Prediction Query
SELECT T.TMEMBER FROM DEPTS AS D CROSS JOIN TEAMS AS T WHERE D.DPROJ = T.TPROJ AND D.DNAME = 'SECURITY';

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(2,)
*/