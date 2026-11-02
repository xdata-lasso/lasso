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
INSERT INTO superpower (id, power_name) VALUES (99, 'default2'), (79, 'default1'), (0, 'default1'), (100, 'default1'), (101, 'default2'), (80, 'default2'), (81, 'default2'), (1, 'default1'), (2, 'default2');
INSERT INTO race (id, race) VALUES (80, NULL), (99, 'default1'), (1, NULL), (0, NULL), (79, 'default1'), (81, NULL), (100, 'default1'), (101, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (80, 'default1'), (99, NULL), (81, NULL), (79, NULL), (0, NULL), (1, 'default1'), (101, NULL), (100, 'default1'), (2, 'default1');
INSERT INTO gender (id, gender) VALUES (101, 'default1'), (80, NULL), (79, 'default1'), (81, 'default1');
INSERT INTO colour (id, colour) VALUES (99, 'default1'), (1, NULL), (101, 'default2'), (0, NULL), (80, 'default1'), (79, 'default2'), (81, 'default1'), (100, 'default1');
INSERT INTO alignment (id, alignment) VALUES (81, NULL), (0, 'default2'), (80, 'default1'), (1, NULL), (79, NULL), (100, NULL), (99, NULL), (101, 'default2'), (2, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (80, 1, 80, 101, 0, 81, 100, 100, 'default2', NULL, 79, 0), (79, 99, 1, 81, 0, 101, 0, 79, NULL, 'default1', 81, NULL), (100, 0, 0, 80, NULL, 99, 79, 80, 'default1', NULL, 0, 101), (101, 2, 81, 79, 79, 101, 80, NULL, 'default1', 'default2', 100, 80), (81, NULL, 101, 80, 79, 100, 81, 79, NULL, 'default1', 99, 79), (99, 81, 1, NULL, 81, 100, 100, NULL, 'default2', 'default1', 1, 79), (0, NULL, 1, 79, 100, 1, NULL, 80, 'default2', 'default2', NULL, NULL), (1, 1, NULL, 79, 99, 101, 99, 1, 'default2', 'default1', 101, 99), (2, 79, 99, 81, 79, 0, 100, 100, 'default1', NULL, 99, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (100, 100), (0, 80), (79, 81), (99, NULL), (81, 1), (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm * 100 > (SELECT AVG(height_cm) FROM superhero) * 80;

/*
Gold Result:
('default2',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm > 0.8 * (SELECT AVG(height_cm) FROM superhero);

/*
Prediction Result:
('default2',)
('default1',)
*/