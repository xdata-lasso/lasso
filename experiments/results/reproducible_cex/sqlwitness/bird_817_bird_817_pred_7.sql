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
INSERT INTO race (id, race) VALUES (1, 'default2'), (0, 'default2'), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'Male'), (7, NULL), (8, 'Blue'), (9, 'default1'), (10, NULL), (11, 'default1'), (12, 'default2'), (13, 'Male'), (14, 'default1'), (15, 'Blue');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Male'), (1, 'default2'), (2, 'Blue');
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, 'Male'), (2, 'default1'), (3, 'Male'), (4, 'Male'), (5, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, 'Blue'), (2, 'default2'), (3, 'Blue'), (4, 'Blue');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, NULL, 4, 4, 3, 0, 5, 0, 'Blue', 'default1', 0, 1), (0, NULL, 3, NULL, 0, NULL, 5, 0, 'default1', 'default1', 0, 0), (2, NULL, 4, 5, 3, 2, 0, 4, 'Blue', 'Male', NULL, NULL), (3, NULL, 0, 2, 3, NULL, 14, 4, 'Blue', 'Blue', NULL, 1), (4, NULL, 0, 3, 1, 0, 1, 1, 'default1', NULL, 0, 1), (5, NULL, 0, 2, NULL, 2, NULL, 4, 'default2', NULL, NULL, 0), (6, NULL, 2, 3, 2, 2, 10, 0, 'default1', NULL, 1, 1), (7, NULL, 4, 0, 0, 0, NULL, NULL, 'Male', 'Male', NULL, 1), (8, NULL, 2, 0, 0, 2, 2, 1, NULL, 'Male', 0, 1), (9, NULL, 2, 1, 4, NULL, 11, 3, 'Male', 'Male', 1, NULL), (10, NULL, NULL, 3, 0, NULL, 6, 0, NULL, NULL, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
('default2',)
('default2',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT r.race FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id JOIN colour AS c ON s.hair_colour_id = c.id JOIN race AS r ON s.race_id = r.id WHERE g.gender = 'Male' AND c.colour = 'Blue';

/*
Prediction Result:
('default2',)
('default1',)
*/