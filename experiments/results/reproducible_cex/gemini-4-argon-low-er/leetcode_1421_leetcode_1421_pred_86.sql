-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NPV (id, year, npv) VALUES (1, 10, 50);
INSERT INTO NPV (id, year, npv) VALUES (12, 3, 100);
INSERT INTO Queries (id, year) VALUES (1, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1, 23, 0)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, COALESCE(NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON Q.ID || Q.YEAR = N.ID || N.YEAR;

/*
Prediction Result:
(1, 23, 100)
*/