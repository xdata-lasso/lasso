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
INSERT INTO race (id, race) VALUES (1, 'default2'), (0, 'default2'), (2, 'Black');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default1'), (1, NULL), (2, 'default2'), (3, 'Black'), (4, 'default1'), (5, 'Black'), (6, 'default1'), (7, 'Black'), (8, 'default2'), (9, 'Black'), (10, 'Black'), (11, 'Black');
INSERT INTO gender (id, gender) VALUES (0, 'Black'), (1, 'default1'), (2, 'Black'), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default1'), (8, NULL), (9, 'Black'), (10, NULL), (11, NULL), (12, NULL), (13, NULL), (14, NULL), (15, 'default1'), (16, 'Black'), (17, 'Black'), (18, 'default1'), (19, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, NULL), (2, 'Black'), (3, 'Black'), (4, NULL), (5, NULL), (6, 'default2'), (7, 'Black'), (8, 'default1'), (9, 'Black'), (10, NULL), (11, 'Black'), (12, 'Black'), (13, 'default1'), (14, 'Black');
INSERT INTO alignment (id, alignment) VALUES (0, 'default2'), (1, 'default1'), (2, 'default1'), (3, 'default1'), (4, 'Black'), (5, 'default1'), (6, NULL), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, NULL), (12, NULL), (13, 'Black'), (14, NULL), (15, NULL), (16, 'Black'), (17, 'default1'), (18, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 6, 0, 3, 1, 11, 1, 5, 'Black', 'default1', 0, 0), (0, 8, 13, 15, 11, 11, 0, 9, 'Black', 'default2', NULL, NULL), (2, 5, 9, 6, 6, 11, NULL, 11, 'default1', NULL, NULL, 0), (3, 12, 2, NULL, NULL, 5, 2, 13, 'Black', 'default2', 0, NULL), (4, 11, 8, 5, 8, 4, 2, 10, 'Black', 'default1', 1, 0), (5, 2, 3, 4, 3, 9, NULL, NULL, 'Black', 'Black', 1, 1), (6, 18, 2, 5, 0, 8, 0, 0, NULL, 'Black', NULL, NULL), (7, 1, 13, 11, 5, 2, 1, 3, 'default1', 'Black', NULL, 0), (8, 17, 6, 9, 10, 3, NULL, 7, 'Black', 'default2', NULL, 1), (9, 3, 11, 10, 9, 9, 2, 0, 'default1', NULL, 0, 1), (10, 8, 0, 15, 12, 0, 0, 4, 'default2', 'default1', 0, 0), (11, 13, 14, 6, 12, 7, 2, 6, 'default2', 'default2', 0, 1), (12, 1, 13, 10, 3, 9, 0, 5, 'Black', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id AND T1.hair_colour_id = T2.id WHERE T2.colour = 'Black';

/*
Gold Result:
('Black',)
*/

-- Prediction Query
SELECT DISTINCT superhero.superhero_name FROM superhero INNER JOIN colour AS eye_colour ON superhero.eye_colour_id = eye_colour.id INNER JOIN colour AS hair_colour ON superhero.hair_colour_id = hair_colour.id WHERE eye_colour.colour = 'Black' AND hair_colour.colour = 'Black';

/*
Prediction Result:
('Black',)
('default1',)
('default2',)
*/