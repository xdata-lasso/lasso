-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NPV (id, year, npv) VALUES (1, NULL, 10);
INSERT INTO Queries (id, year) VALUES (1, NULL);
INSERT INTO Queries (id, year) VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1, None, 0)
(1, None, 0)
*/

-- Prediction Query
SELECT DISTINCT A.ID, A.YEAR, COALESCE(B.NPV, 0) AS NPV FROM QUERIES AS A LEFT JOIN NPV AS B ON A.ID = B.ID AND A.YEAR = B.YEAR;

/*
Prediction Result:
(1, None, 0)
*/