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
-- DATASET 1
INSERT INTO race (id, race) VALUES (10, 'Vampire');
INSERT INTO race (id, race) VALUES (20, 'Human');
INSERT INTO race (id, race) VALUES (30, 'Vampire Hunter');
INSERT INTO race (id, race) VALUES (40, 'vampire');
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (1, 'Blade', 'Eric Brooks', 10);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (2, 'Blade', 'Daywalker', 10);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (3, NULL, 'Nameless Vampire', 10);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (4, 'Morbius', NULL, 10);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (5, 'Batman', 'Bruce Wayne', 20);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (6, 'Vampire', 'Fake Vampire', 20);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (7, 'Buffy', 'Buffy Summers', 30);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (8, 'Dracula', 'Vlad Tepes', 40);
INSERT INTO superhero (id, superhero_name, full_name, race_id) VALUES (9, 'Mystery', 'Unknown Hero', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Vampire';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(superhero.id) AS count FROM superhero JOIN race ON superhero.race_id = race.id WHERE race.race = 'Vampire';

/*
Prediction Result:
(4,)
*/