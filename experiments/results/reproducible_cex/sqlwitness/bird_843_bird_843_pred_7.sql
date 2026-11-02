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
INSERT INTO superpower (id, power_name) VALUES (0, NULL), (1, 'Intelligence');
INSERT INTO race (id, race) VALUES (0, 'default2'), (1, 'Intelligence'), (2, NULL), (3, 'default2'), (4, 'default1'), (5, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, NULL), (0, 'default1'), (2, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 0, 1, NULL, 1, NULL, NULL, NULL, NULL, 'default1', 0, 0), (0, 2, 1, NULL, 1, NULL, 0, 1, NULL, 'default1', 1, 1), (2, 1, NULL, NULL, NULL, NULL, 4, NULL, 'Intelligence', 'default2', NULL, 1), (3, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, 'default1', NULL, 0), (4, 2, 1, NULL, 1, NULL, 5, NULL, 'default2', 'default2', NULL, NULL), (5, 0, NULL, NULL, 1, NULL, 4, NULL, 'default1', 'default1', NULL, NULL), (6, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'Intelligence', 0, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (NULL, 1), (2, 0), (4, NULL), (NULL, NULL), (4, 1), (3, 1), (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.hero_id FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T2.power_name = 'Intelligence';

/*
Gold Result:
(None,)
(4,)
(3,)
*/

-- Prediction Query
SELECT T2.hero_id FROM superpower AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.power_id INNER JOIN superhero AS T3 ON T2.hero_id = T3.id WHERE T1.power_name = 'Intelligence';

/*
Prediction Result:
(4,)
(3,)
*/