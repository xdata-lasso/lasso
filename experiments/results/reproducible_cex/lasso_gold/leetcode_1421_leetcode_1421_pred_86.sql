-- Schema DDL
CREATE TABLE "NPV" ("id" INTEGER UNIQUE, "year" INTEGER, "npv" INTEGER, PRIMARY KEY ("id", "year"), CHECK ("npv" >= 0));

CREATE TABLE "Queries" ("id" INTEGER, "year" INTEGER, PRIMARY KEY ("id", "year"), FOREIGN KEY ("id") REFERENCES "NPV" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "npv" ("id", "year", "npv") VALUES (1117, 1118, 1119);
INSERT INTO "npv" ("id", "year", "npv") VALUES (1122, 1123, 1119);
INSERT INTO "npv" ("id", "year", "npv") VALUES (111, 71118, 1126);
INSERT INTO "npv" ("id", "year", "npv") VALUES (1133, 71118, 1126);
INSERT INTO "queries" ("id", "year") VALUES (1117, 1118);
INSERT INTO "queries" ("id", "year") VALUES (1117, 1125);
INSERT INTO "queries" ("id", "year") VALUES (111, 71118);
INSERT INTO "queries" ("id", "year") VALUES (111, 1134);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv FROM Queries AS q LEFT JOIN NPV AS n ON q.id = n.id AND q.year = n.year;

/*
Gold Result:
(1117, 1118, 1119)
(1117, 1125, 0)
(111, 71118, 1126)
(111, 1134, 0)
*/

-- Prediction Query
SELECT Q.ID, Q.YEAR, COALESCE(NPV, 0) AS NPV FROM QUERIES AS Q LEFT JOIN NPV AS N ON Q.ID || Q.YEAR = N.ID || N.YEAR;

/*
Prediction Result:
(1117, 1118, 1119)
(1117, 1118, 1126)
(1117, 1125, 0)
(111, 71118, 1119)
(111, 71118, 1126)
(111, 1134, 0)
*/