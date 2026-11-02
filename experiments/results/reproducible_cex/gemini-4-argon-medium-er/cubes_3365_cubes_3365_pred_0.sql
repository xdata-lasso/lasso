-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Alice', 'A', 'D1', 10);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 2, 'Bob', 'B', 'D2', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT duration FROM (SELECT * FROM (SELECT * FROM (SELECT CHARACTER, duration, MAX(age) AS age FROM actor GROUP BY CHARACTER, duration) ORDER BY CHARACTER) LIMIT 1);

/*
Gold Result:
('D1',)
*/

-- Prediction Query
SELECT Duration FROM actor ORDER BY Age DESC, actor.actor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('D2',)
*/