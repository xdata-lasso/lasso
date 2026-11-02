-- Schema DDL
CREATE TABLE "triangle" ("x" INTEGER, "y" INTEGER, "z" INTEGER, PRIMARY KEY ("x", "y", "z"), CHECK ("x" > 0), CHECK ("y" > 0), CHECK ("z" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO triangle (x, y, z) VALUES (NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT x, y, z, CASE WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No' END AS triangle FROM triangle;

/*
Gold Result:
(None, 1, 1, 'No')
*/

-- Prediction Query
SELECT X, Y, Z, IIF((X + Y <= Z OR X + Z <= Y OR Z + Y <= X), 'No', 'Yes') AS TRIANGLE FROM TRIANGLE;

/*
Prediction Result:
(None, 1, 1, 'Yes')
*/