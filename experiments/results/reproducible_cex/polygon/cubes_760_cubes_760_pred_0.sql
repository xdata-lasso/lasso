-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (14, '13', 13, '13', '13', '13', '13');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (13, '22', 23, '24', '25', '26', '27');
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (13, NULL, NULL, '13', '13', 13);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (15, 13, NULL, '28', '29', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID ORDER BY T2.Year DESC, T1.actor_id NULLS LAST, T2.musical_id NULLS LAST;

/*
Prediction Result:
(None,)
*/