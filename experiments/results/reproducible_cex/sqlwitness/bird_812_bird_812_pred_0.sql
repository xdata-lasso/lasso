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
INSERT INTO race (id, race) VALUES (6, 'Blue'), (0, 'default2'), (4, NULL), (1, 'default2'), (5, NULL), (2, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (6, 'Blue'), (0, 'default1');
INSERT INTO gender (id, gender) VALUES (5, 'Blue'), (4, NULL), (6, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'Blue'), (1, 'Blue'), (5, 'default2');
INSERT INTO alignment (id, alignment) VALUES (6, 'default1'), (1, 'Blue'), (5, NULL), (4, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, NULL, 1, 5, 5, NULL, 4, 1, 'default2', NULL, 1, 6), (4, 4, 5, 4, 5, 6, 6, 1, 'default2', 'default1', 4, 6), (6, 1, 1, 6, 1, 0, 4, 5, 'Blue', 'default2', 4, 4), (0, 1, 1, 5, 0, 6, 4, 0, 'default1', NULL, 1, NULL), (5, NULL, 1, NULL, 1, 6, 0, 5, 'default2', 'default2', 6, 0), (2, NULL, 1, 6, 1, 0, 2, 1, NULL, 'default1', 0, 4), (3, 1, 5, 4, NULL, NULL, 5, 0, 'default1', 'default2', 6, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T2.colour = 'Blue' LIMIT 5;

/*
Gold Result:
('default1',)
('default2',)
(None,)
('default2',)
('Blue',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Blue' LIMIT 5;

/*
Prediction Result:
(None,)
(None,)
('default1',)
('default2',)
('default2',)
*/