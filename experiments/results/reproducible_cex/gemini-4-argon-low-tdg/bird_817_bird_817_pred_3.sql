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
-- Tests basic matching, WHERE predicate variations (AND vs OR, missing predicates), and distinct IDs across tables to catch wrong join columns.
INSERT INTO colour (id, colour) VALUES (10, 'Blue');
INSERT INTO colour (id, colour) VALUES (11, 'Red');
INSERT INTO gender (id, gender) VALUES (20, 'Male');
INSERT INTO gender (id, gender) VALUES (21, 'Female');
INSERT INTO race (id, race) VALUES (30, 'Mutant');
INSERT INTO race (id, race) VALUES (31, 'Human');
INSERT INTO race (id, race) VALUES (32, 'Alien');
INSERT INTO race (id, race) VALUES (33, 'Cyborg');
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id) VALUES (100, 'Hero_Match', 20, 11, 10, 11, 30);
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id) VALUES (101, 'Hero_Blue_Female', 21, 11, 10, 11, 31);
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id) VALUES (102, 'Hero_Red_Male', 20, 11, 11, 11, 32);
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id) VALUES (103, 'Hero_Red_Female', 21, 11, 11, 11, 33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
('Mutant',)
*/

-- Prediction Query
SELECT race.race FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN colour ON superhero.hair_colour_id = colour.id JOIN race ON superhero.race_id = race.id WHERE gender.gender = 'Male' AND colour.colour = 'blue';

/*
Prediction Result:
*/