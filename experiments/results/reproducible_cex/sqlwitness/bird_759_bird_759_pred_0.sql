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
INSERT INTO race (id, race) VALUES (0, NULL), (2, 'default1'), (1, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, NULL), (2, 'default1'), (3, 'default1'), (4, 'default1');
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, 'default2'), (2, 'default1'), (3, NULL), (4, 'default2');
INSERT INTO colour (id, colour) VALUES (2, NULL), (0, 'default1'), (1, 'default1'), (3, 'default1'), (4, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, NULL, 4, NULL, 0, 0, 0, 'default1', NULL, 0, 2), (2, 0, 3, 3, 4, NULL, 2, 2, 'default1', 'default1', 1, 1), (1, NULL, NULL, 4, 1, 2, 0, 3, NULL, NULL, NULL, NULL), (3, 0, 2, 1, 3, 1, 0, NULL, 'default2', NULL, 2, NULL), (4, NULL, 3, 2, NULL, 3, 1, 2, NULL, 'default2', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT colour.colour FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.weight_kg = (SELECT MAX(weight_kg) FROM superhero);

/*
Prediction Result:
*/