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
INSERT INTO superpower (id, power_name) VALUES (1, NULL), (0, 'default1'), (2, NULL), (3, 'default2'), (4, NULL), (5, 'default1'), (6, 'default1'), (7, 'default2');
INSERT INTO race (id, race) VALUES (1, NULL), (0, NULL), (2, 'Amazo'), (3, 'Amazo'), (4, NULL), (5, 'default1'), (6, NULL), (7, 'Amazo'), (8, NULL), (9, 'Amazo'), (10, 'Amazo');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (0, NULL), (2, 'default2'), (3, 'Amazo');
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, NULL), (2, 'default2'), (3, 'Amazo'), (4, 'Amazo'), (5, 'default2'), (6, NULL), (7, 'Amazo'), (8, NULL), (9, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, 'Amazo'), (2, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'Amazo'), (2, 'default1'), (3, 'default2'), (4, NULL), (5, NULL), (6, 'Amazo'), (7, 'default2'), (8, 'default1'), (9, 'default2'), (10, NULL), (11, 'Amazo'), (12, NULL), (13, 'Amazo'), (14, 'default2'), (15, 'Amazo');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 12, 2, 9, 1, 2, 4, 2, NULL, 'Amazo', 0, 0), (1, 13, 2, 0, 2, 2, 8, 1, NULL, 'default1', 1, NULL), (2, 14, 0, 4, 1, 0, 5, NULL, 'default2', NULL, NULL, 1), (3, 3, NULL, 3, 0, 1, 4, 1, 'Amazo', 'default2', NULL, 0), (4, NULL, 1, 9, NULL, 1, 6, 2, 'Amazo', 'default1', 1, 1), (5, 14, 2, 8, 0, NULL, 6, 2, 'default2', NULL, NULL, 0), (6, 12, 0, 7, 0, 2, 4, 1, 'default1', 'Amazo', 0, 0), (7, 8, 1, 3, 2, 2, 8, 1, NULL, 'default1', 0, 0), (8, 4, 0, 8, 0, 3, 1, 1, 'default2', 'default2', NULL, 0), (9, 11, 2, 9, 1, 3, 2, 2, 'Amazo', 'default1', 1, 1), (10, 4, NULL, 9, 1, 2, NULL, 2, 'default2', 'Amazo', NULL, 0), (11, 15, 2, 4, 2, NULL, 0, NULL, 'Amazo', 'default1', NULL, NULL), (12, 14, 2, 8, 1, 3, 7, 2, 'default1', 'Amazo', 0, NULL), (13, 3, NULL, 8, 1, 3, 6, 1, 'default2', 'default2', NULL, 0), (14, 3, 2, NULL, NULL, 0, 5, NULL, 'default2', 'default1', 0, NULL), (15, 5, 1, 3, 1, 2, 9, 1, 'Amazo', 'default1', 0, 0);
INSERT INTO hero_power (hero_id, power_id) VALUES (NULL, 7), (8, 0), (15, NULL), (NULL, 2), (3, 4), (10, 3), (12, 7), (NULL, NULL), (10, 3), (4, 3), (NULL, 7), (7, 1), (10, 3), (5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.power_id) FROM hero_power AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id WHERE T2.superhero_name = 'Amazo';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(power_id) FROM hero_power WHERE hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Amazo');

/*
Prediction Result:
(1,)
*/