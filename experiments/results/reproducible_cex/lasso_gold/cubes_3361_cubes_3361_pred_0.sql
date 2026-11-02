-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1006, 'Olivia Moore', 1010, 'animal', 'capital', 'old', 'present');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1007, 'Donald Lewis', 1010, 'show', 'win', 'finally', 'present');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1008, 'Ashley James', 1010, 'machine', 'human', 'themselves', 'present');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1009, 'Gregory Baker', 1010, 'not', 'bar', 'production', 'present');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1011, NULL, 1015, 'hear', 'science', 'away', 'none');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1012, NULL, 1015, 'determine', 'write', 'politics', 'none');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1013, NULL, 1015, 'religious', 'result', 'prove', 'none');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1014, NULL, 1015, 'example', 'raise', 'Congress', 'none');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT RESULT, YEAR, MAX(n) AS n FROM (SELECT RESULT, YEAR, COUNT(*) AS n FROM musical GROUP BY RESULT, YEAR) GROUP BY RESULT, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
('present',)
*/

-- Prediction Query
SELECT RESULT FROM musical GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('none',)
*/