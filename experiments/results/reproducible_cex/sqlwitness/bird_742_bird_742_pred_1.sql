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
INSERT INTO race (id, race) VALUES (0, 'default2'), (1, 'default2'), (2, 'Vampire'), (3, 'Vampire'), (4, NULL), (5, NULL), (6, 'Vampire'), (7, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, 'default2'), (2, NULL), (3, 'default2'), (4, 'Vampire'), (5, 'default2'), (6, NULL), (7, NULL), (8, 'Vampire'), (9, NULL), (10, 'default2'), (11, 'default1'), (12, NULL);
INSERT INTO gender (id, gender) VALUES (1, 'default2'), (0, 'default2'), (2, 'default2'), (3, 'default2'), (4, NULL), (5, 'Vampire'), (6, 'default1'), (7, 'Vampire'), (8, 'default2'), (9, 'Vampire'), (10, 'default1'), (11, NULL), (12, 'default2');
INSERT INTO colour (id, colour) VALUES (0, 'default2'), (1, 'Vampire'), (2, 'Vampire'), (3, 'default1'), (4, 'Vampire'), (5, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'Vampire');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, NULL, 3, 2, 2, 4, 5, NULL, 'default2', 0, NULL), (1, NULL, 4, 6, 0, 3, 6, 5, NULL, 'default1', 0, NULL), (2, NULL, 5, 8, 1, 8, 1, NULL, 'Vampire', NULL, 1, 1), (3, 1, 0, 1, 5, 1, 2, 4, NULL, 'default1', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Vampire';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(superhero.id) FROM superhero INNER JOIN race ON superhero.race_id = race.id WHERE race.race = 'Vampire';

/*
Prediction Result:
(2,)
*/