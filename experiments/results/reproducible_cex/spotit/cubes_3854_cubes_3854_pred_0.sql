-- Schema DDL
CREATE TABLE "GRAPES" (
    "ID" INT,
    "GRAPE" TEXT,
    "COLOR" TEXT,
    PRIMARY KEY ("ID"),
    UNIQUE ("GRAPE")
);
CREATE TABLE "APPELLATIONS" (
    "NO" INT,
    "APPELATION" TEXT,
    "COUNTY" TEXT,
    "STATE" TEXT,
    "AREA" TEXT,
    "ISAVA" TEXT,
    PRIMARY KEY ("NO"),
    UNIQUE ("APPELATION")
);
CREATE TABLE "WINE" (
    "APPELATION" TEXT,
    "GRAPE" TEXT,
    "NO" INT,
    "WINERY" TEXT,
    "STATE" TEXT,
    "NAME" TEXT,
    "YEAR" INT,
    "PRICE" INT,
    "SCORE" INT,
    "CASES" INT,
    "DRINK" TEXT,
    FOREIGN KEY ("APPELATION") REFERENCES "APPELLATIONS"("APPELATION"),
    FOREIGN KEY ("GRAPE") REFERENCES "GRAPES"("GRAPE")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO GRAPES VALUES (-1, 0, 0);
INSERT INTO GRAPES VALUES (0, -1, 0);
INSERT INTO APPELLATIONS VALUES (0, -1, 0, 0, 0, 0);
INSERT INTO APPELLATIONS VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO WINE VALUES (-1, -1, 0, -1, 0, 0, 0, 0, 0, -1, 0);
INSERT INTO WINE VALUES (0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT winery FROM (SELECT LHS.no AS NO, LHS.grape AS grape, LHS.winery AS winery, LHS.appelation AS appelation, LHS.state AS state, LHS.name AS name, LHS.year AS YEAR, LHS.price AS price, LHS.score AS score, LHS.cases AS cases, LHS.drink AS drink FROM wine AS LHS INNER JOIN (SELECT state, MIN(score) AS score FROM wine GROUP BY state) AS RHS ON (LHS.state = RHS.state AND LHS.score = RHS.score)) ORDER BY winery;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Winery FROM WINE ORDER BY SCORE, WINE.appelation NULLS LAST, WINE.grape NULLS LAST, WINE.no NULLS LAST, WINE.winery NULLS LAST, WINE.state NULLS LAST, WINE.name NULLS LAST, WINE.year NULLS LAST, WINE.price NULLS LAST, WINE.cases NULLS LAST, WINE.drink NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/