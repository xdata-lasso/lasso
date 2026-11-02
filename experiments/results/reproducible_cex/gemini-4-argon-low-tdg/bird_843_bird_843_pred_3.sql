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
INSERT INTO alignment (id, alignment) VALUES (1, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (10, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (20, 'Strength');
INSERT INTO colour (id, colour) VALUES (1, 'Black');
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Intelligence');
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Brainiac', 'Vril Dox', 1, 1, 1, 1, 1, 1, 1, 180, 80);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'Intelligence', 'John Doe', 1, 1, 1, 1, 1, 1, 1, 175, 75);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Brawn', 'Jane Doe', 1, 1, 1, 1, 1, 1, 1, 190, 100);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (100, 'WrongJoin', 'Test Hero', 1, 1, 1, 1, 1, 1, 1, 180, 80);
INSERT INTO superpower (id, power_name) VALUES (1, 'Strength');
INSERT INTO superpower (id, power_name) VALUES (100, 'Intelligence');
INSERT INTO superpower (id, power_name) VALUES (200, 'Super Intelligence');
INSERT INTO superpower (id, power_name) VALUES (300, 'intelligence');
INSERT INTO superpower (id, power_name) VALUES (400, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 200);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 300);
INSERT INTO hero_power (hero_id, power_id) VALUES (100, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (NULL, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, NULL);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 10, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 10, 50);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 20, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.hero_id FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T2.power_name = 'Intelligence';

/*
Gold Result:
(1,)
(None,)
*/

-- Prediction Query
SELECT superhero.id FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Intelligence';

/*
Prediction Result:
(1,)
*/