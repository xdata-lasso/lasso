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
INSERT INTO race (id, race) VALUES (99, 'default1'), (0, 'default2'), (101, 'default2'), (100, NULL), (1, 'default2'), (2, 'default1'), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default2'), (7, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (101, NULL), (0, 'default1'), (1, 'default1'), (100, NULL), (99, 'default2'), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, NULL);
INSERT INTO gender (id, gender) VALUES (0, NULL), (99, NULL), (100, NULL), (101, 'default2');
INSERT INTO colour (id, colour) VALUES (99, NULL), (100, NULL), (101, 'default2'), (0, 'default2'), (1, 'default2'), (2, 'default2'), (3, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'default1'), (101, 'default2'), (0, 'default1'), (100, 'default2'), (99, NULL);
INSERT INTO alignment (id, alignment) VALUES (99, NULL), (1, 'default1'), (100, 'default2'), (101, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (99, 1, 0, 100, 101, 3, 4, 2, 'default2', 'default2', 99, 0), (100, NULL, 2, NULL, 101, 0, 101, 100, NULL, 'default2', 0, 100), (1, NULL, NULL, 99, 100, 2, 101, 100, 'default2', NULL, 100, 99), (101, 101, 1, 0, 2, 100, 5, NULL, 'default2', 'default2', 0, 100), (0, NULL, 3, NULL, 1, 0, 2, 1, NULL, NULL, 101, 100), (2, NULL, 3, NULL, 99, 100, 4, 100, 'default2', 'default2', 99, 0), (3, NULL, 99, 0, 2, 3, 5, NULL, NULL, 'default2', 1, 1), (4, 1, 2, 101, 99, 1, 7, 1, 'default1', 'default1', NULL, NULL);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (1, 0, NULL), (101, 2, 100), (1, 2, 100), (0, 3, 0), (0, 4, 101), (100, 0, 1), (1, 99, 99), (100, 101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.colour FROM colour AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.skin_colour_id INNER JOIN hero_attribute AS T3 ON T2.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Prediction Result:
(None,)
(None,)
*/