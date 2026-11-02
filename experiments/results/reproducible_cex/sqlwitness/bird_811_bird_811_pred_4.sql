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
INSERT INTO superpower (id, power_name) VALUES (1, 'Atom IV'), (0, 'default1'), (2, 'default2');
INSERT INTO race (id, race) VALUES (0, 'default2'), (1, 'default2'), (2, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (0, 'default2'), (2, 'default2'), (3, NULL), (4, 'Atom IV'), (5, 'Atom IV'), (6, 'default1');
INSERT INTO gender (id, gender) VALUES (0, 'Atom IV');
INSERT INTO colour (id, colour) VALUES (1, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, 1, 0, 1, 5, 0, NULL, NULL, NULL, NULL, 1), (1, NULL, NULL, 0, NULL, 1, 2, NULL, NULL, 'default1', 1, 1), (2, NULL, NULL, 0, NULL, 0, NULL, 1, 'Atom IV', NULL, 1, 1), (3, NULL, 1, 0, NULL, 0, NULL, NULL, 'Atom IV', 'default1', NULL, 1), (4, NULL, NULL, 0, 1, 6, NULL, NULL, 'Atom IV', NULL, NULL, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, NULL), (4, 2), (3, 2), (NULL, 2), (NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T3.id = T2.power_id WHERE T1.superhero_name = 'Atom IV';

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
SELECT a.alignment, sp.power_name FROM superhero AS h JOIN alignment AS a ON h.alignment_id = a.id JOIN hero_power AS hp ON h.id = hp.hero_id JOIN superpower AS sp ON hp.power_id = sp.id WHERE h.superhero_name = 'Atom IV';

/*
Prediction Result:
*/