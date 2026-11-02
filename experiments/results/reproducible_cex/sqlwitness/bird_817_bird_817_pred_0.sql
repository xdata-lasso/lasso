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
INSERT INTO race (id, race) VALUES (1, 'Blue'), (0, 'default2'), (2, 'blue'), (3, 'male'), (4, NULL), (5, 'default2'), (6, 'blue'), (7, 'blue'), (8, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Male'), (1, 'Male'), (2, 'Male'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, 'male'), (7, 'Male'), (8, 'default1'), (9, NULL), (10, 'default1'), (11, 'male'), (12, 'default2');
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, 'default2'), (2, 'Male'), (3, 'male'), (4, 'blue'), (5, 'default1'), (6, 'default2'), (7, 'blue'), (8, 'Male'), (9, 'Blue'), (10, 'male'), (11, 'blue'), (12, 'default2'), (13, 'default2');
INSERT INTO colour (id, colour) VALUES (0, 'male'), (1, 'Male'), (2, 'Male'), (3, 'default2'), (4, 'male'), (5, 'default2'), (6, NULL), (7, 'Male'), (8, 'male'), (9, NULL), (10, 'Male'), (11, 'Male'), (12, 'blue'), (13, 'blue'), (14, 'default1'), (15, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, 'blue'), (0, 'Male'), (2, 'default2'), (3, NULL), (4, 'Blue'), (5, 'default1'), (6, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 3, 7, 1, 13, 1, NULL, 7, 'blue', 'default1', 1, NULL), (0, 5, 3, 1, 5, 10, NULL, 12, 'default2', 'Blue', NULL, NULL), (2, 4, 9, 3, 12, 2, 7, 5, NULL, 'blue', 1, NULL), (3, 5, 11, 10, 8, 1, 5, 15, NULL, 'default1', 1, 0), (4, 6, 6, 13, 6, 4, 2, 4, 'male', 'male', NULL, 1), (5, 1, 8, 10, 13, NULL, 0, 3, 'blue', 'Male', 1, 1), (6, 1, 1, 10, 4, 3, 0, 9, 'default1', NULL, NULL, NULL), (7, 5, 10, 0, 9, 3, 1, 14, 'default1', 'blue', 1, NULL), (8, 5, 12, 1, 12, 9, NULL, 7, 'male', NULL, 1, 1), (9, NULL, 11, 10, 0, 1, 6, 10, 'male', 'blue', 0, 0), (10, 2, 9, 10, 5, 3, 4, 9, 'default2', 'default2', NULL, NULL), (11, 1, 2, 13, 4, 1, 1, 4, 'male', 'male', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'blue' AND T4.gender = 'male';

/*
Prediction Result:
('blue',)
('default2',)
*/