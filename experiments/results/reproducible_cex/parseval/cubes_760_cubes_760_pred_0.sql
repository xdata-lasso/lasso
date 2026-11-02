-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: actor --
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1, NULL, 'act_afd337', 'value', 'value', 1);

INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (2, NULL, 'act_afd337', 'value', 'value', 1);

INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (3, NULL, 'act_afd337', 'value', 'value', 1);

INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (4, NULL, NULL, 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
(None,)
('act_afd337',)
('act_afd337',)
('act_afd337',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID ORDER BY T2.Year DESC, T1.actor_id NULLS LAST, T2.musical_id NULLS LAST;

/*
Prediction Result:
*/