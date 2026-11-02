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
INSERT INTO race (id, race) VALUES (4, NULL), (3, 'Neutral'), (1, NULL), (2, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (0, 'Neutral'), (4, 'Neutral'), (3, 'default1');
INSERT INTO colour (id, colour) VALUES (2, 'default1'), (4, NULL), (1, 'Neutral'), (3, 'Neutral');
INSERT INTO attribute (id, attribute_name) VALUES (1, NULL);
INSERT INTO alignment (id, alignment) VALUES (3, 'Neutral'), (1, 'Neutral');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (4, 1, 1, 1, 4, NULL, NULL, 3, NULL, 'Neutral', NULL, 0), (3, 3, 2, 1, 4, NULL, 4, 3, 'default1', 'default2', 1, NULL), (1, NULL, 4, 0, 2, NULL, 2, NULL, 'default2', 'default1', NULL, 2), (2, NULL, 4, 1, 4, NULL, NULL, 1, 'Neutral', NULL, NULL, 1), (0, NULL, 4, 3, 3, NULL, 1, 4, 'default1', 'Neutral', 3, NULL);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (1, NULL, 4), (NULL, 2, NULL), (1, 0, 3), (1, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT AVG(hero_attribute.attribute_value) FROM superhero INNER JOIN hero_attribute ON superhero.id = hero_attribute.hero_id WHERE superhero.alignment_id = 3;

/*
Prediction Result:
(None,)
*/