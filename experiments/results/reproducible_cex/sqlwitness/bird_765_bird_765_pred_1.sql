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
INSERT INTO superpower (id, power_name) VALUES (1, 'Stealth'), (0, 'Stealth'), (2, 'Stealth'), (3, 'Stealth');
INSERT INTO race (id, race) VALUES (0, 'Stealth'), (1, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (1, 'default2'), (2, 'default1'), (3, NULL);
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, 'default2'), (2, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, NULL), (0, NULL), (2, 'Stealth');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 2, 0, 2, NULL, NULL, NULL, 0, 'default2', 'Stealth', 0, 1), (0, 1, NULL, 1, 1, 1, 0, 1, 'default1', 'default1', NULL, NULL), (2, 2, NULL, 1, 1, 0, 0, 0, 'default1', 'default2', 0, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 2), (1, 1), (2, NULL), (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T2.power_name = 'Stealth';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT hp.hero_id) AS stealth_hero_count FROM superpower AS sp INNER JOIN hero_power AS hp ON sp.id = hp.power_id WHERE sp.power_name = 'Stealth';

/*
Prediction Result:
(1,)
*/