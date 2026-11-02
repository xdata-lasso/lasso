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
INSERT INTO "alignment" ("id", "alignment") VALUES (1001, 'purpose');
INSERT INTO "colour" ("id", "colour") VALUES (1002, 'brother');
INSERT INTO "colour" ("id", "colour") VALUES (1007, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1008, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1003, 'Female');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1004, 'Dark Horse Comics');
INSERT INTO "race" ("id", "race") VALUES (1005, 'ago');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1006, 'Danielle Taylor', 'Patrick Gardner', 1003, 1002, 1007, 1008, 1005, 1004, 1001, 1009, 1010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.eye_colour_id, T1.hair_colour_id, T1.skin_colour_id FROM superhero AS T1 INNER JOIN publisher AS T2 ON T2.id = T1.publisher_id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T2.publisher_name = 'Dark Horse Comics' AND T3.gender = 'Female';

/*
Gold Result:
(1002, 1007, 1008)
*/

-- Prediction Query
SELECT "colour1"."colour" AS "eye_colour", "colour2"."colour" AS "hair_colour", "colour3"."colour" AS "skin_colour" FROM "superhero" INNER JOIN "colour" AS "colour1" ON "superhero"."eye_colour_id" = "colour1"."id" INNER JOIN "colour" AS "colour2" ON "superhero"."hair_colour_id" = "colour2"."id" INNER JOIN "colour" AS "colour3" ON "superhero"."skin_colour_id" = "colour3"."id" INNER JOIN "gender" ON "superhero"."gender_id" = "gender"."id" INNER JOIN "publisher" ON "superhero"."publisher_id" = "publisher"."id" WHERE "gender"."gender" = 'Female' AND "publisher"."publisher_name" = 'Dark Horse Comics';

/*
Prediction Result:
('brother', None, None)
*/