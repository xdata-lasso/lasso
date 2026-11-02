-- Schema DDL
CREATE TABLE alignment (id INTEGER NOT NULL PRIMARY KEY, alignment TEXT DEFAULT NULL);

CREATE TABLE attribute (id INTEGER NOT NULL PRIMARY KEY, attribute_name TEXT DEFAULT NULL);

CREATE TABLE colour (id INTEGER NOT NULL PRIMARY KEY, colour TEXT DEFAULT NULL);

CREATE TABLE gender (id INTEGER NOT NULL PRIMARY KEY, gender TEXT DEFAULT NULL);

CREATE TABLE publisher (id INTEGER NOT NULL PRIMARY KEY, publisher_name TEXT DEFAULT NULL);

CREATE TABLE race (id INTEGER NOT NULL PRIMARY KEY, race TEXT DEFAULT NULL);

CREATE TABLE superhero (id INTEGER NOT NULL PRIMARY KEY, superhero_name TEXT DEFAULT NULL, full_name TEXT DEFAULT NULL, gender_id INTEGER DEFAULT NULL, eye_colour_id INTEGER DEFAULT NULL, hair_colour_id INTEGER DEFAULT NULL, skin_colour_id INTEGER DEFAULT NULL, race_id INTEGER DEFAULT NULL, publisher_id INTEGER DEFAULT NULL, alignment_id INTEGER DEFAULT NULL, height_cm INTEGER DEFAULT NULL, weight_kg INTEGER DEFAULT NULL, FOREIGN KEY (alignment_id) REFERENCES alignment (id), FOREIGN KEY (eye_colour_id) REFERENCES colour (id), FOREIGN KEY (gender_id) REFERENCES gender (id), FOREIGN KEY (hair_colour_id) REFERENCES colour (id), FOREIGN KEY (publisher_id) REFERENCES publisher (id), FOREIGN KEY (race_id) REFERENCES race (id), FOREIGN KEY (skin_colour_id) REFERENCES colour (id));

CREATE TABLE hero_attribute (hero_id INTEGER DEFAULT NULL, attribute_id INTEGER DEFAULT NULL, attribute_value INTEGER DEFAULT NULL, FOREIGN KEY (attribute_id) REFERENCES attribute (id), FOREIGN KEY (hero_id) REFERENCES superhero (id));

CREATE TABLE superpower (id INTEGER NOT NULL PRIMARY KEY, power_name TEXT DEFAULT NULL);

CREATE TABLE hero_power (hero_id INTEGER DEFAULT NULL, power_id INTEGER DEFAULT NULL, FOREIGN KEY (hero_id) REFERENCES superhero (id), FOREIGN KEY (power_id) REFERENCES superpower (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO race (id, race) VALUES (0, 'default2'), (1, 'default1'), (2, 'default1'), (3, 'Dark Horse Comics'), (4, 'Female'), (5, 'Dark Horse Comics'), (6, 'Female');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default1'), (1, 'Female'), (2, 'Female'), (3, 'Female'), (4, NULL), (5, 'Dark Horse Comics'), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, 'Female'), (10, 'Female'), (11, 'Female');
INSERT INTO gender (id, gender) VALUES (1, 'Female'), (0, 'default1'), (2, 'default1'), (3, 'Dark Horse Comics'), (4, 'Dark Horse Comics'), (5, NULL), (6, 'Female'), (7, 'default2'), (8, 'default2'), (9, 'Dark Horse Comics'), (10, 'Female'), (11, 'Female'), (12, 'default1');
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, 'default2'), (2, NULL), (3, 'default1'), (4, 'default2'), (5, 'Female'), (6, 'default1'), (7, 'Female'), (8, 'Female'), (9, 'Female'), (10, 'default2'), (11, 'default2'), (12, 'Female'), (13, NULL), (14, 'default2'), (15, 'default2'), (16, NULL), (17, 'Female'), (18, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 1, 7, 3, 7, 6, 3, 9, 'Female', 'Female', 0, 1), (0, 0, 7, 8, NULL, NULL, 5, 10, 'default1', 'default2', 1, 1), (2, 0, 1, 8, 11, 6, 6, 0, NULL, 'default2', 0, 1), (3, NULL, 7, 1, 2, 6, 4, 17, 'Female', 'default1', 0, NULL), (4, 1, 6, 5, 7, 7, 1, 17, 'default2', 'Dark Horse Comics', 0, 1), (5, 0, 2, 10, 13, 4, 5, 5, 'Dark Horse Comics', NULL, 1, NULL), (6, NULL, 11, 6, 13, 7, 2, 13, 'default2', 'default2', 0, NULL), (7, NULL, 10, 10, 12, 7, 5, 0, NULL, 'default2', 0, 1), (8, 1, 9, 5, 9, 11, 4, 13, 'default2', 'Female', 0, NULL), (9, NULL, 0, 12, 0, 0, 4, 0, NULL, NULL, 1, 1), (10, 1, 14, 6, 11, 11, 3, 1, NULL, 'Female', 1, 0), (11, 1, 17, 0, 8, NULL, 1, 15, 'Dark Horse Comics', 'Dark Horse Comics', 0, 0), (12, NULL, 16, 11, 4, 4, NULL, 0, 'Dark Horse Comics', NULL, 1, 0), (13, NULL, 5, 7, 16, 2, 0, 1, NULL, NULL, 1, 1), (14, 1, 11, 6, 4, 8, 6, 4, 'default1', 'default1', 0, 1), (15, 0, 2, 12, 7, 2, 0, NULL, 'Female', 'default1', 1, NULL), (16, 0, 5, 1, 7, 0, 4, 9, 'Female', 'default2', 0, NULL), (17, 0, 13, 2, 9, 2, 6, 13, NULL, NULL, 0, 1), (18, 1, 15, 12, 12, 5, 2, NULL, 'Female', 'Dark Horse Comics', 1, NULL), (19, NULL, 3, 0, NULL, 2, NULL, 3, 'default2', 'Dark Horse Comics', 0, 0), (20, 1, 8, 0, 2, 6, 5, 5, 'Dark Horse Comics', NULL, 1, NULL), (21, 0, NULL, 0, 4, 6, 1, 16, 'default1', NULL, 0, 0), (22, 1, 10, 7, 0, 4, 0, 8, 'default2', 'default2', 0, NULL), (23, 0, 17, 4, 4, 7, 1, 8, NULL, NULL, NULL, 1), (24, 0, 18, 10, 9, 5, 1, 10, 'default2', 'Female', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.eye_colour_id, T1.hair_colour_id, T1.skin_colour_id FROM superhero AS T1 INNER JOIN publisher AS T2 ON T2.id = T1.publisher_id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T2.publisher_name = 'Dark Horse Comics' AND T3.gender = 'Female';

/*
Gold Result:
(18, 9, 10)
*/

-- Prediction Query
SELECT "colour1"."colour" AS "eye_colour", "colour2"."colour" AS "hair_colour", "colour3"."colour" AS "skin_colour" FROM "superhero" INNER JOIN "colour" AS "colour1" ON "superhero"."eye_colour_id" = "colour1"."id" INNER JOIN "colour" AS "colour2" ON "superhero"."hair_colour_id" = "colour2"."id" INNER JOIN "colour" AS "colour3" ON "superhero"."skin_colour_id" = "colour3"."id" INNER JOIN "gender" ON "superhero"."gender_id" = "gender"."id" INNER JOIN "publisher" ON "superhero"."publisher_id" = "publisher"."id" WHERE "gender"."gender" = 'Female' AND "publisher"."publisher_name" = 'Dark Horse Comics';

/*
Prediction Result:
(None, 'Female', 'default2')
*/