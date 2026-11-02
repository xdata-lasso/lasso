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
INSERT INTO superpower (id, power_name) VALUES (6, 'default1'), (0, 'default1'), (5, 'Male');
INSERT INTO race (id, race) VALUES (1, 'Male'), (5, 'default2'), (0, NULL), (4, 'default1'), (6, 'default1'), (2, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (6, 'default1'), (1, NULL);
INSERT INTO gender (id, gender) VALUES (5, 'default1'), (1, NULL), (6, 'default2'), (4, 'default1'), (0, 'Male'), (2, 'Male'), (3, 'default1'), (7, 'Male'), (8, 'default1'), (9, 'default2'), (10, 'default2'), (11, NULL), (12, 'Male'), (13, NULL);
INSERT INTO colour (id, colour) VALUES (1, NULL), (4, 'default2'), (6, 'default2'), (5, NULL), (0, 'default2'), (2, 'Male'), (3, NULL), (7, 'default1'), (8, 'default2'), (9, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, 'Male'), (0, 'default1'), (5, 'default2'), (4, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 0, 9, 7, 6, NULL, NULL, NULL, 'default1', NULL, 0, 6), (4, 5, 1, 5, NULL, NULL, 1, 4, 'Male', NULL, NULL, NULL), (6, NULL, 3, 0, 2, 6, 0, 4, 'default2', 'Male', 1, 5), (1, 0, 7, 2, 9, 6, 6, NULL, 'default2', NULL, 1, 1), (5, 1, 9, 8, 8, 6, 2, 6, 'default2', NULL, 5, 5), (2, 5, 2, 1, 5, NULL, NULL, 4, NULL, NULL, NULL, NULL), (3, 1, 9, 3, 8, NULL, 0, 6, 'default2', 'Male', 6, 0), (7, 1, NULL, 2, 6, NULL, 2, 6, 'Male', 'default1', NULL, 6), (8, 1, NULL, 7, 7, 1, 6, 2, 'default2', NULL, 6, 1), (9, 5, 3, 7, 7, 1, NULL, 5, NULL, NULL, 1, 4), (10, 4, NULL, 7, 6, 6, 0, 2, 'Male', NULL, 1, 0), (11, 0, 5, 0, 6, 6, 6, 8, 'Male', 'default1', NULL, 5), (12, NULL, NULL, 1, 4, 1, 1, 9, 'default1', NULL, NULL, 0), (13, 0, 5, 13, 4, 1, NULL, 9, 'default2', 'Male', 5, 6);
INSERT INTO hero_power (hero_id, power_id) VALUES (8, 5), (2, NULL), (10, 5), (1, NULL), (3, 6), (1, 5), (8, NULL), (5, 6), (2, NULL), (4, 6), (1, 0), (9, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T3.id = T2.power_id INNER JOIN gender AS T4 ON T4.id = T1.gender_id WHERE T4.gender = 'Male' LIMIT 5;

/*
Gold Result:
('Male',)
('Male',)
('Male',)
('default1',)
('Male',)
*/

-- Prediction Query
SELECT DISTINCT sp.power_name FROM superhero AS sh JOIN gender AS g ON sh.gender_id = g.id JOIN hero_power AS hp ON sh.id = hp.hero_id JOIN superpower AS sp ON hp.power_id = sp.id WHERE g.gender = 'Male' LIMIT 5;

/*
Prediction Result:
('Male',)
('default1',)
*/