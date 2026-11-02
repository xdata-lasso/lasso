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
-- DATASET 1
-- Tests basic positive match, column confusion (eye vs hair vs skin), and DISTINCT vs non-DISTINCT behavior.
INSERT INTO colour (id, colour) VALUES (1, 'Gold');
INSERT INTO colour (id, colour) VALUES (2, 'Blue');
INSERT INTO colour (id, colour) VALUES (3, 'Green');
INSERT INTO colour (id, colour) VALUES (4, 'Red');
-- Hero 1 & 2: Both have Gold skin and Blue eyes (Tests if query wrongly applies DISTINCT).
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (1, 'GoldenBoy', 2, 3, 1);
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (2, 'Aurum', 2, 4, 1);
-- Hero 3: Gold eyes, Red skin (Catches swapped eye_colour_id and skin_colour_id conditions).
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (3, 'GoldEye', 1, 3, 4);
-- Hero 4: Green eyes, Gold hair, Red skin (Catches hair_colour_id used instead of skin_colour_id).
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (4, 'GoldHair', 3, 1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T3.colour = 'Gold';

/*
Gold Result:
('Blue',)
('Blue',)
*/

-- Prediction Query
SELECT DISTINCT "colour"."colour" FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id" WHERE "superhero"."skin_colour_id" IN (SELECT "id" FROM "colour" WHERE "colour" = 'Gold');

/*
Prediction Result:
('Blue',)
*/