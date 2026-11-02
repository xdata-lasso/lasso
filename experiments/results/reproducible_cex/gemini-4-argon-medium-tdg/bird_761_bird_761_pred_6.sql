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
-- Tests exact boundary conditions (<, <=, =, >=, >), constant mutations (78, 79, 80, 100), DISTINCT vs ALL in SELECT, and column selection (full_name vs superhero_name).
-- Average weight_kg across all 5 superheroes is (78 + 79 + 80 + 80 + 183) / 5 = 500 / 5 = 100.0.
-- Threshold: weight_kg * 100 > 100.0 * 79 (7900).
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO gender (id, gender) VALUES (2, 'Female');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (1, 'Hero78', 'Full78', 1, 200, 78);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (2, 'Hero79', 'Full79', 1, 200, 79);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (3, 'Hero80A', 'DuplicateFull80', 1, 50, 80);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (4, 'Hero80B', 'DuplicateFull80', 1, 50, 80);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (5, 'HeroHeavy', 'FullHeavy', 1, 50, 183);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('DuplicateFull80',)
('DuplicateFull80',)
('FullHeavy',)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 WHERE T1.gender_id = (SELECT id FROM gender WHERE gender = 'Male') AND T1.weight_kg > (SELECT AVG(weight_kg) FROM superhero) * 0.79;

/*
Prediction Result:
('Hero80A',)
('Hero80B',)
('HeroHeavy',)
*/