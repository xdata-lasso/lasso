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
INSERT INTO superpower (id, power_name) VALUES (80, NULL), (99, 'default2');
INSERT INTO race (id, race) VALUES (99, NULL), (0, 'default1'), (101, 'default2'), (79, NULL), (80, 'default2'), (81, NULL), (100, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (100, NULL), (1, NULL), (80, 'default1'), (81, 'default2'), (0, NULL), (79, 'default2'), (99, 'default2'), (101, 'default1'), (2, NULL), (3, NULL);
INSERT INTO gender (id, gender) VALUES (99, NULL), (1, NULL);
INSERT INTO alignment (id, alignment) VALUES (100, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 100, NULL, 99, NULL, 2, 80, NULL, 'default2', 'default1', 81, NULL), (80, 100, NULL, 1, NULL, 100, 80, NULL, 'default1', NULL, 100, 100), (99, 100, NULL, NULL, NULL, 79, 79, NULL, NULL, 'default2', 81, 99), (79, 100, NULL, NULL, NULL, 100, 80, NULL, NULL, NULL, 80, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (79, NULL), (NULL, NULL), (1, NULL), (79, 80), (NULL, 80), (79, 99), (79, 99), (79, 80), (80, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm * 100 > (SELECT AVG(height_cm) FROM superhero) * 80;

/*
Gold Result:
(None,)
('default2',)
('default2',)
(None,)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT sp.power_name FROM superpower AS sp JOIN hero_power AS hp ON sp.id = hp.power_id JOIN superhero AS h ON hp.hero_id = h.id WHERE h.height_cm > (SELECT AVG(height_cm) * 0.8 FROM superhero);

/*
Prediction Result:
(None,)
('default2',)
*/