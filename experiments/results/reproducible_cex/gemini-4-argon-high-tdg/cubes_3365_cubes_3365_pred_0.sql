-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Hamilton', 2016, 'Tony', 'Best Musical', 'Lin-Manuel', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Wicked', 2004, 'Tony', 'Best Actress', 'Idina', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'Cats', 1983, 'Tony', 'Best Score', 'Andrew', 'Nominated');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Aaron', 'Charlie', '1 year', 60);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 2, 'Zack', 'Bravo', '9 years', 18);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 2, 'Zack', 'Bravo', '9 years', 22);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, 3, 'Mike', 'Alpha', '5 years', 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT duration FROM (SELECT * FROM (SELECT * FROM (SELECT CHARACTER, duration, MAX(age) AS age FROM actor GROUP BY CHARACTER, duration) ORDER BY CHARACTER) LIMIT 1);

/*
Gold Result:
('5 years',)
*/

-- Prediction Query
SELECT Duration FROM actor ORDER BY Age DESC, actor.actor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1 year',)
*/