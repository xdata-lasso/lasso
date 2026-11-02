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
INSERT INTO race (id, race) VALUES (1, NULL), (0, 'Vampire'), (2, NULL), (3, NULL), (4, 'Vampire'), (5, 'Vampire');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Vampire'), (1, 'default2'), (2, 'Vampire'), (3, 'default2'), (4, 'default1'), (5, 'Vampire');
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, 'Vampire'), (2, 'Vampire'), (3, 'Vampire'), (4, 'Vampire'), (5, 'default2'), (6, NULL), (7, 'default1'), (8, 'default2'), (9, 'default2');
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, 'default1'), (2, 'Vampire'), (3, 'Vampire'), (4, 'default1'), (5, 'Vampire');
INSERT INTO alignment (id, alignment) VALUES (1, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, 4, 0, 3, 5, NULL, 2, 'Vampire', 'default1', NULL, 0), (1, 1, 3, 2, NULL, 5, 4, 5, NULL, 'Vampire', 1, NULL), (2, 1, 5, 1, 1, 4, 3, 3, NULL, NULL, 0, NULL), (3, 1, 2, 9, 4, 2, 4, 4, 'default2', 'Vampire', 1, 1), (4, 1, 0, 2, 2, 5, 0, 0, 'default2', 'Vampire', NULL, NULL), (5, NULL, 1, 7, 0, NULL, NULL, 3, 'default2', NULL, NULL, 0), (6, NULL, 1, 0, 3, 0, 4, 1, 'default1', 'default1', 0, 0), (7, NULL, 3, 6, 0, 3, 4, 5, NULL, NULL, 0, NULL), (8, 1, 4, 4, 2, 1, 5, 0, 'default1', 'default2', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Vampire';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Vampire';

/*
Prediction Result:
(6,)
*/