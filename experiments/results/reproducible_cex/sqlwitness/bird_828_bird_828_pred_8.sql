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
INSERT INTO race (id, race) VALUES (100, 'Speed'), (1, NULL), (99, 'Speed'), (0, 'default2'), (101, NULL), (2, NULL), (3, 'default1'), (4, NULL), (5, 'Speed');
INSERT INTO publisher (id, publisher_name) VALUES (101, 'Speed'), (0, 'default1'), (100, 'Speed'), (2, 'Speed'), (99, NULL), (1, 'default1'), (3, 'default1'), (4, NULL), (5, 'default2'), (6, 'default2'), (7, 'Speed');
INSERT INTO gender (id, gender) VALUES (2, 'Speed'), (0, 'Speed'), (100, 'default2'), (101, 'Speed'), (1, 'default1'), (99, 'Speed'), (3, NULL), (4, 'Speed'), (5, 'Speed'), (6, 'default1'), (7, 'default2'), (8, 'Speed');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (100, 'default1'), (0, 'default1'), (99, 'Speed'), (101, 'default2'), (2, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (100, NULL), (1, 'default1'), (2, 'default1'), (0, 'default2'), (99, 'Speed'), (101, 'default1'), (3, 'default1'), (4, NULL);
INSERT INTO alignment (id, alignment) VALUES (100, NULL), (2, 'Speed'), (101, 'default2'), (1, 'Speed'), (0, 'Speed'), (99, 'Speed'), (3, 'default2'), (4, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 100, 2, 0, 2, 7, 4, 2, 'Speed', 'default1', 1, 2), (99, 3, 0, 0, 1, 2, 3, 0, NULL, 'Speed', 1, 99), (100, 3, 100, 8, 100, 7, 101, 100, 'Speed', 'default1', 99, 101), (101, 3, 100, 2, 99, 7, 1, 101, 'default2', 'default2', 0, 2), (1, 100, 1, NULL, 1, 5, NULL, 100, 'default2', 'Speed', 100, 101), (2, 99, 1, 100, 0, 1, 3, 100, 'Speed', 'default1', 0, 1), (3, NULL, 100, 0, NULL, 99, 4, 100, NULL, 'default1', 101, 2), (4, NULL, 99, 7, 100, 3, 99, 1, 'default1', 'Speed', 101, 1), (5, 2, 101, 1, NULL, 5, 3, 101, 'default1', NULL, 1, 99), (6, 1, 100, 7, 2, 100, 101, 101, 'Speed', NULL, 100, 1), (7, 99, 0, 3, NULL, NULL, 99, 2, NULL, 'default2', 1, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (99, 0, 0), (2, 4, 99), (NULL, 2, NULL), (99, 101, NULL), (0, 4, 0), (101, 6, 2), (4, 99, 2), (100, 101, 0), (2, 5, 100), (NULL, 5, 2), (2, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.superhero_name) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T2.attribute_name = 'Speed' ORDER BY T1.attribute_value DESC, T1.hero_id NULLS LAST, T1.attribute_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS s INNER JOIN hero_attribute AS ha ON s.id = ha.hero_id INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Speed' AND ha.attribute_value = 100;

/*
Prediction Result:
(0,)
*/