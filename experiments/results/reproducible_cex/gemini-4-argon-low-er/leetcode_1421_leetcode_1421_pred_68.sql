-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NPV (id, year, npv) VALUES (1, 2000, NULL);
INSERT INTO Queries (id, year) VALUES (1, 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1, 2000, 0)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, CASE WHEN Q.ID IN (N.ID) AND Q.YEAR IN (N.YEAR) THEN N.NPV ELSE 0 END AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON Q.ID = N.ID AND Q.YEAR = N.YEAR;

/*
Prediction Result:
(1, 2000, None)
*/