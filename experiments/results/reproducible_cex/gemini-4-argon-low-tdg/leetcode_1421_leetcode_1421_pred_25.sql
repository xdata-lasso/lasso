-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO NPV (id, year, npv) VALUES (1, 2018, 100);
INSERT INTO NPV (id, year, npv) VALUES (7, 2020, 30);
INSERT INTO NPV (id, year, npv) VALUES (13, 2019, 40);
INSERT INTO NPV (id, year, npv) VALUES (2, 2008, 121);
INSERT INTO NPV (id, year, npv) VALUES (3, 2009, 12);
INSERT INTO NPV (id, year, npv) VALUES (11, 2020, 99);
INSERT INTO Queries (id, year) VALUES (1, 2019);
INSERT INTO Queries (id, year) VALUES (2, 2008);
INSERT INTO Queries (id, year) VALUES (3, 2009);
INSERT INTO Queries (id, year) VALUES (7, 2018);
INSERT INTO Queries (id, year) VALUES (7, 2019);
INSERT INTO Queries (id, year) VALUES (7, 2020);
INSERT INTO Queries (id, year) VALUES (13, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1, 2019, 0)
(2, 2008, 121)
(3, 2009, 12)
(7, 2018, 0)
(7, 2019, 0)
(7, 2020, 30)
(13, 2019, 40)
*/

-- Prediction Query
SELECT Q.YEAR, Q.ID, COALESCE(N.NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON N.YEAR = Q.YEAR AND N.ID = Q.ID;

/*
Prediction Result:
(2019, 1, 0)
(2008, 2, 121)
(2009, 3, 12)
(2018, 7, 0)
(2019, 7, 0)
(2020, 7, 30)
(2019, 13, 40)
*/