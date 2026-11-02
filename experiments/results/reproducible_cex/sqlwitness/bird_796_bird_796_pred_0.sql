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
INSERT INTO race (id, race) VALUES (1, 'default1'), (0, NULL), (2, '3-D Man'), (3, 'default2'), (4, '3-D Man'), (5, '3-D Man'), (6, '3-D Man'), (7, NULL), (8, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default1'), (1, 'default1'), (2, 'default2'), (3, 'default2'), (4, '3-D Man'), (5, '3-D Man'), (6, '3-D Man'), (7, NULL);
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, NULL), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, 'default1');
INSERT INTO colour (id, colour) VALUES (1, NULL), (0, 'default2'), (2, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (0, 'default2'), (1, 'default2'), (2, 'default1'), (3, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, NULL), (0, 'default1'), (2, 'default2'), (3, '3-D Man');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 2, 1, 4, 2, 2, 4, 0, 'default1', '3-D Man', 1, NULL), (0, NULL, 1, 4, NULL, 7, 4, NULL, 'default1', NULL, NULL, 0), (2, 1, 2, NULL, 1, 3, 8, 1, 'default1', NULL, 1, NULL), (3, 3, 0, 3, NULL, 0, 3, 2, NULL, 'default1', 0, NULL), (4, 1, NULL, 5, 0, NULL, 6, 2, NULL, 'default1', 0, 1), (5, 0, 2, 3, 0, 4, 3, 2, '3-D Man', 'default1', 0, 1), (6, 2, NULL, 5, NULL, NULL, NULL, NULL, 'default2', 'default1', 0, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (1, NULL, 1), (NULL, 0, 0), (3, 2, 0), (1, 5, 1), (2, 3, 1), (2, 3, 1), (0, 3, 0), (NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name, T2.attribute_value FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = '3-D Man';

/*
Gold Result:
('default2', 1)
*/

-- Prediction Query
SELECT T2.attribute_name, T3.attribute_value FROM superhero AS T1 INNER JOIN attribute AS T2 ON T1.id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T1.superhero_name = '3-D Man';

/*
Prediction Result:
*/