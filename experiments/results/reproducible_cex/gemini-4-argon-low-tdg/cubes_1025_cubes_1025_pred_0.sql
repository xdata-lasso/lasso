-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Zeta_AZ_Low', 'AZ', 10000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Echo_AZ_BndLow', 'AZ', 13000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Alpha_AZ_Mid', 'AZ', 14000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Delta_LA_Mid', 'LA', 14000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Bravo_LA_BndHigh', 'LA', 15000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Charlie_LA_High', 'LA', 20000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Foxtrot_CA_Mid', 'CA', 14000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Golf_CA_Low', 'CA', 10000.0);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Hotel_AZ_NullEnr', 'AZ', NULL);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('India_NullState_Mid', NULL, 14000.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1.0, 'John', 'yes', 1000.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2.0, 'Jane', 'no', 1200.0);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1.0, 'Zeta_AZ_Low', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2.0, 'Zeta_AZ_Low', 'striker', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM "college" WHERE ("enr" > 13000.0 OR "enr" < 15000.0)) WHERE ("state" = 'AZ' OR "state" = 'LA') ORDER BY cname, "cname" NULLS LAST;

/*
Gold Result:
('Alpha_AZ_Mid',)
('Bravo_LA_BndHigh',)
('Charlie_LA_High',)
('Delta_LA_Mid',)
('Echo_AZ_BndLow',)
('Zeta_AZ_Low',)
*/

-- Prediction Query
SELECT cName FROM College WHERE enr < 13000 AND state = 'AZ' UNION SELECT cName FROM College WHERE enr > 15000 AND state = 'LA';

/*
Prediction Result:
('Charlie_LA_High',)
('Zeta_AZ_Low',)
*/