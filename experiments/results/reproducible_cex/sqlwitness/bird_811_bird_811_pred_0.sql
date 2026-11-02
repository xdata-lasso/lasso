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
INSERT INTO superpower (id, power_name) VALUES (0, 'default1'), (1, 'Atom IV'), (2, NULL), (3, 'Atom IV'), (4, 'Atom IV'), (5, 'default1'), (6, 'Atom IV'), (7, 'default2'), (8, NULL), (9, 'Atom IV'), (10, 'default1'), (11, 'default1'), (12, 'Atom IV'), (13, 'Atom IV'), (14, NULL);
INSERT INTO race (id, race) VALUES (0, NULL), (1, 'default2'), (2, NULL), (3, 'default2'), (4, 'default2'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, 'default1'), (9, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL);
INSERT INTO gender (id, gender) VALUES (1, NULL), (0, 'Atom IV'), (2, 'default1'), (3, 'default2'), (4, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, 'default2'), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'Atom IV'), (5, 'default1'), (6, 'default2'), (7, NULL), (8, 'Atom IV'), (9, 'default2'), (10, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, NULL, NULL, 4, 1, NULL, 6, 1, 'default1', 'Atom IV', 1, 0), (0, 2, 1, 4, 1, 0, 4, 1, 'Atom IV', 'Atom IV', NULL, NULL), (2, 1, NULL, NULL, NULL, NULL, 4, 1, 'Atom IV', 'Atom IV', NULL, NULL), (3, 2, 1, 0, NULL, 0, 6, NULL, 'Atom IV', 'default1', NULL, 1), (4, 8, 1, 3, NULL, NULL, 3, 1, NULL, 'Atom IV', 0, NULL), (5, 4, NULL, 0, NULL, NULL, 8, 1, 'default1', NULL, NULL, 0), (6, NULL, 1, 1, 1, 0, 2, NULL, 'default1', 'default2', NULL, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 8), (1, 14), (4, 10), (3, 3), (4, 11), (1, NULL), (4, 0), (4, 4), (2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T3.id = T2.power_id WHERE T1.superhero_name = 'Atom IV';

/*
Gold Result:
(None,)
('Atom IV',)
('Atom IV',)
*/

-- Prediction Query
SELECT T1.alignment, T3.power_name FROM alignment AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.alignment_id INNER JOIN hero_power AS T4 ON T2.id = T4.hero_id INNER JOIN superpower AS T3 ON T4.power_id = T3.id WHERE T2.superhero_name = 'Atom IV';

/*
Prediction Result:
('default2', None)
('default1', 'Atom IV')
('default2', 'Atom IV')
*/