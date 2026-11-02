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
INSERT INTO superpower (id, power_name) VALUES (1, 'default1'), (0, NULL), (2, 'Abomination'), (3, NULL), (4, 'Abomination'), (5, NULL), (6, 'Abomination'), (7, 'Abomination'), (8, NULL), (9, NULL), (10, NULL), (11, 'Abomination');
INSERT INTO race (id, race) VALUES (0, NULL), (1, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (0, 'default2'), (2, 'default2'), (3, 'default1'), (4, NULL), (5, 'default1'), (6, 'default2'), (7, 'Abomination'), (8, 'default2'), (9, 'default2'), (10, 'Abomination');
INSERT INTO gender (id, gender) VALUES (0, 'Abomination'), (1, 'default2'), (2, 'Abomination'), (3, NULL), (4, NULL), (5, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, 'Abomination'), (0, 'Abomination'), (2, 'Abomination'), (3, 'Abomination'), (4, 'Abomination'), (5, 'default1'), (6, 'default1'), (7, NULL), (8, NULL), (9, NULL), (10, 'default1'), (11, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 0, 0, NULL, 0, 8, NULL, 0, 'default2', 'default1', 1, NULL), (0, NULL, NULL, 2, 0, 9, 0, NULL, 'default2', NULL, 0, NULL), (2, 6, 0, 1, 1, 5, 0, 1, NULL, 'default2', 0, 1), (3, NULL, 1, 4, 0, 2, 0, 0, 'default2', NULL, 0, 1), (4, 9, NULL, 3, 0, 5, NULL, 1, 'default1', 'default2', 0, 0), (5, 11, 1, 1, NULL, 4, NULL, 0, 'default1', 'default1', NULL, 0), (6, NULL, NULL, 1, NULL, 5, 1, 1, 'Abomination', 'Abomination', 1, NULL), (7, 9, 0, 0, 0, 8, 1, 0, 'Abomination', 'Abomination', 0, NULL), (8, 1, 1, 5, 1, 5, 0, 0, 'default2', 'Abomination', 0, 1), (9, 4, 0, 1, 0, 3, 0, 1, 'default1', 'default1', 0, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 9), (6, 10), (6, 4), (NULL, 10), (2, 3), (NULL, 4), (8, 5), (1, 2), (8, 7), (0, 1), (8, 11), (6, 3), (3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.superhero_name = 'Abomination';

/*
Gold Result:
(None,)
('Abomination',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT t3.power_name FROM superhero AS t1 INNER JOIN hero_power AS t2 ON t1.id = t2.hero_id INNER JOIN superpower AS t3 ON t2.power_id = t3.id WHERE t1.superhero_name = 'Abomination';

/*
Prediction Result:
(None,)
('Abomination',)
*/