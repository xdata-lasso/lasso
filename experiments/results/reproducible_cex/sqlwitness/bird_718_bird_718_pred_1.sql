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
INSERT INTO superpower (id, power_name) VALUES (0, 'default1'), (1, 'Super Strength'), (2, 'default2'), (3, 'Super Strength'), (4, 'default1'), (5, 'default1');
INSERT INTO race (id, race) VALUES (1, NULL), (0, 'default1'), (2, 'Super Strength'), (3, NULL), (4, NULL), (5, NULL), (6, 'default2'), (7, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, 'default1'), (2, 'default2'), (3, 'Super Strength'), (4, 'Super Strength');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (0, 'default1'), (2, 'default1'), (3, 'Super Strength'), (4, NULL), (5, 'default2'), (6, 'default2'), (7, 'Super Strength');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, 'default1'), (2, NULL), (3, 'default1'), (4, 'default1'), (5, 'Super Strength'), (6, 'default1'), (7, 'default1'), (8, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, 2, 3, 1, 3, 0, 0, 'default2', NULL, 1, 1), (1, NULL, 3, 7, 5, 4, NULL, 5, 'default1', 'Super Strength', NULL, 0);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T2.power_name = 'Super Strength';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(hero_id) FROM hero_power WHERE power_id = (SELECT id FROM superpower WHERE power_name = 'Super Strength');

/*
Prediction Result:
(0,)
*/