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
INSERT INTO race (id, race) VALUES (0, 'default1'), (1, NULL), (2, NULL), (3, 'default1'), (4, 'Aquababy'), (5, NULL), (6, 'Aquababy'), (7, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (1, 'default1'), (2, 'Aquababy'), (3, 'default2'), (4, NULL), (5, 'default1'), (6, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, NULL), (2, 'Aquababy'), (3, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (0, NULL), (1, 'default1'), (2, 'Aquababy'), (3, 'Aquababy'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default2'), (8, 'default1');
INSERT INTO alignment (id, alignment) VALUES (1, 'Aquababy'), (0, NULL), (2, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 1, 2, NULL, 2, 4, 4, 1, 'default2', 'default1', 0, 1), (1, NULL, 3, NULL, NULL, 2, 0, 3, NULL, 'Aquababy', 0, 1), (2, 1, 1, NULL, 2, 1, 5, 3, 'default2', NULL, 0, 1), (3, 2, 1, NULL, 2, 2, 2, 0, 'default2', NULL, 0, 0), (4, NULL, 3, NULL, 3, NULL, 4, 3, 'Aquababy', 'default1', 0, 0), (5, NULL, 3, NULL, NULL, 2, NULL, NULL, NULL, 'Aquababy', NULL, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (NULL, 4, NULL), (2, 2, 0), (8, 4, NULL), (3, NULL, 0), (2, 1, NULL), (2, 5, NULL), (7, 4, 0), (8, 5, 1), (NULL, 2, 0), (5, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.attribute_value FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id WHERE T1.superhero_name = 'Aquababy';

/*
Gold Result:
(None,)
(None,)
(0,)
*/

-- Prediction Query
SELECT T2.attribute_name, T1.attribute_value FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T3.superhero_name = 'Aquababy';

/*
Prediction Result:
('default1', None)
('default2', 0)
*/