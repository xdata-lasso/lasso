-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1001, 1005, 'Allison Hill', 'agreement', 'option', 1009);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1002, 1005, 'Noah Rhodes', 'agreement', 'option', 1022.0);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1003, 1005, 'Angie Henderson', 'agreement', 'option', 1035.0);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1004, 1005, 'Daniel Wagner', 'agreement', 'option', 1048.0);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1005, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT duration FROM (SELECT * FROM (SELECT * FROM (SELECT CHARACTER, duration, MAX(age) AS age FROM actor GROUP BY CHARACTER, duration) ORDER BY CHARACTER) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Duration FROM actor ORDER BY Age DESC, actor.actor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('option',)
*/