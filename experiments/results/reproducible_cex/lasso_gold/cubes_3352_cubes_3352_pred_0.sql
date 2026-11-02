-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1006, 'Olivia Moore', 1010, 'animal', 'capital', 'old', 'finally');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1007, 'Donald Lewis', 1010, 'show', 'win', 'old', 'themselves');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1008, 'Ashley James', 1010, 'machine', 'human', 'old', 'production');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1009, 'Gregory Baker', 1010, 'not', 'bar', 'old', 'present');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1011, NULL, 1015, 'hear', 'science', 'away', 'politics');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1012, NULL, 1015, 'determine', 'write', 'away', 'prove');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1013, NULL, 1015, 'religious', 'result', 'away', 'Congress');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1014, NULL, 1015, 'example', 'raise', 'away', 'none');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee FROM (SELECT * FROM (SELECT * FROM (SELECT nominee, YEAR, MAX(n) AS n FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) GROUP BY nominee, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
('old',)
*/

-- Prediction Query
SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC, Nominee NULLS LAST LIMIT 1;

/*
Prediction Result:
('away',)
*/