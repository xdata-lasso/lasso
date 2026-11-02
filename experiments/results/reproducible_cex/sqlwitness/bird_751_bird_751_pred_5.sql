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
INSERT INTO superpower (id, power_name) VALUES (5, 'default1'), (6, 'default1'), (1, NULL), (0, 'default2'), (4, 'default2'), (2, 'default1'), (3, 'Male'), (7, 'Male'), (8, 'default2'), (9, 'default1'), (10, 'Male'), (11, 'default1'), (12, 'default1');
INSERT INTO race (id, race) VALUES (5, 'Male'), (4, 'default2'), (1, 'Male'), (6, 'default1'), (0, 'default2'), (2, 'default1'), (3, NULL), (7, NULL), (8, NULL), (9, NULL), (10, 'Male');
INSERT INTO publisher (id, publisher_name) VALUES (6, 'default2'), (4, NULL), (5, NULL), (1, NULL), (0, 'Male');
INSERT INTO gender (id, gender) VALUES (6, 'default2'), (5, 'default2'), (4, 'default2'), (0, 'default1'), (1, 'default1'), (2, 'Male'), (3, NULL), (7, 'Male'), (8, 'Male'), (9, NULL);
INSERT INTO colour (id, colour) VALUES (0, NULL), (5, NULL), (4, 'default2');
INSERT INTO alignment (id, alignment) VALUES (4, 'Male'), (6, 'Male'), (0, 'default2'), (1, 'Male'), (5, NULL), (2, NULL), (3, 'Male'), (7, NULL), (8, 'Male'), (9, 'default1'), (10, 'default2'), (11, 'default1'), (12, 'default1'), (13, 'Male'), (14, 'default2'), (15, 'default1'), (16, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 7, NULL, 4, 0, 4, 10, 0, 'default2', 'default1', 1, 0), (4, 15, NULL, 5, 5, NULL, 2, 0, 'default2', NULL, 5, 6), (1, 14, NULL, 7, 0, 0, 6, NULL, 'default2', 'default1', NULL, 6), (5, 13, 5, 6, 4, 0, 5, 5, 'Male', 'default2', 6, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 9), (0, 4), (5, 5), (1, 3), (1, 9), (NULL, 1), (4, 12), (1, 7), (0, 1), (0, 10), (NULL, 7), (0, 11), (0, 7), (0, 8), (0, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T3.id = T2.power_id INNER JOIN gender AS T4 ON T4.id = T1.gender_id WHERE T4.gender = 'Male' LIMIT 5;

/*
Gold Result:
('default1',)
('Male',)
('default1',)
('Male',)
*/

-- Prediction Query
SELECT DISTINCT sp.power_name FROM superhero AS s INNER JOIN gender AS g ON s.gender_id = g.id INNER JOIN hero_power AS hp ON s.id = hp.hero_id INNER JOIN superpower AS sp ON hp.power_id = sp.id WHERE g.gender = 'Male' LIMIT 5;

/*
Prediction Result:
('default1',)
('Male',)
*/