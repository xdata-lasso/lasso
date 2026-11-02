-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1011, 1012, 'Melissa Peterson', 'clearly', 'dinner', 21);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1013, 1014, 'Gabrielle Davis', 'bill', 'her', -20);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1012, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1014, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor WHERE (age <> 20) ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
('Gabrielle Davis',)
('Melissa Peterson',)
*/

-- Prediction Query
SELECT Name FROM actor WHERE Age <> 20;

/*
Prediction Result:
('Melissa Peterson',)
('Gabrielle Davis',)
*/