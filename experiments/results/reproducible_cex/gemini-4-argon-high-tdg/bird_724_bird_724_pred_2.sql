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
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO colour (id, colour) VALUES (2, 'Blond');
INSERT INTO colour (id, colour) VALUES (3, 'Brown');
INSERT INTO colour (id, colour) VALUES (4, 'Green');
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (1, 'Thor', 'Thor Odinson', 1, 2, 3);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (2, 'SwappedHero', 'Swapped Full', 2, 1, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (3, 'BlueEyeOnly', 'Blue Eye', 1, 3, 2);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (4, 'BlondHairOnly', 'Blond Hair', 4, 2, 1);
INSERT INTO superhero (id, superhero_name, full_name, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (5, 'NeitherHero', 'Neither Full', 3, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Blond';

/*
Gold Result:
('Thor',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN colour AS c1 ON s.eye_colour_id = c1.id INNER JOIN colour AS c2 ON s.hair_colour_id = c2.id INNER JOIN hero_power AS hp ON s.id = hp.hero_id INNER JOIN superpower AS sp ON hp.power_id = sp.id WHERE c1.colour = 'Blue' AND c2.colour = 'Blond' AND sp.power_name = 'Agility';

/*
Prediction Result:
*/