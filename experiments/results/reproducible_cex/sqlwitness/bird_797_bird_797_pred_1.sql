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
INSERT INTO race (id, race) VALUES (9, NULL), (8, 'default2'), (0, 'default2'), (10, 'default1'), (7, 'Blue'), (6, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (8, 'Brown'), (0, NULL);
INSERT INTO gender (id, gender) VALUES (0, 'Blue'), (10, NULL), (9, 'default1'), (1, 'default2'), (7, 'Blue'), (8, 'Blue'), (6, 'default1'), (2, 'Brown'), (3, 'default2'), (4, 'default1'), (5, 'default1');
INSERT INTO colour (id, colour) VALUES (6, 'Blue'), (8, 'Brown');
INSERT INTO alignment (id, alignment) VALUES (9, 'Brown'), (1, 'Blue'), (8, NULL), (10, 'Blue');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (8, NULL, 6, 5, 8, 8, 7, 8, NULL, 'default2', 0, 0), (7, 10, 8, 2, NULL, 0, NULL, 6, 'default1', NULL, 6, 1), (10, 10, 8, 6, 8, 8, 0, NULL, 'Blue', NULL, 6, 6), (1, 8, 6, 1, 6, NULL, 8, 6, 'default2', 'default2', 10, 8), (0, NULL, 8, 3, 8, 8, 9, 6, 'Blue', 'default2', 10, NULL), (6, 10, 6, 2, NULL, 0, 9, NULL, NULL, NULL, NULL, NULL), (9, 9, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL, 6, NULL), (2, 10, 6, 7, 6, 0, 8, 6, NULL, 'default2', 10, 7), (3, 10, 6, NULL, 8, 8, 10, 6, 'Brown', NULL, 10, NULL), (4, 10, NULL, 9, 6, NULL, 6, 8, 'Brown', NULL, 8, 0), (5, 10, 8, NULL, 6, 0, NULL, 8, 'default1', 'Brown', 9, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Brown';

/*
Gold Result:
('Brown',)
(None,)
*/

-- Prediction Query
SELECT superhero_name FROM superhero WHERE eye_colour_id = 7 AND hair_colour_id = 9;

/*
Prediction Result:
*/