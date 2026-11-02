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
INSERT INTO gender (id, gender) VALUES (1, 'Female');
INSERT INTO gender (id, gender) VALUES (2, 'Male');
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO colour (id, colour) VALUES (2, 'Red');
INSERT INTO colour (id, colour) VALUES (3, 'Green');
-- Female, Blue skin (Matches numerator and denominator)
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (1, 'Hero1', 1, 2, 2, 1);
-- Female, Red skin, Blue eyes (Matches denominator only; tests eye_colour_id vs skin_colour_id confusion)
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (2, 'Hero2', 1, 1, 2, 2);
-- Female, Green skin, Blue hair (Matches denominator only; tests hair_colour_id vs skin_colour_id confusion)
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (3, 'Hero3', 1, 2, 1, 3);
-- Female, NULL skin colour (Excluded by INNER JOIN on skin_colour_id; tests INNER JOIN vs LEFT JOIN)
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (4, 'Hero4', 1, 1, 1, NULL);
-- Male, Blue skin (Excluded by WHERE T2.gender = 'Female'; tests gender filter)
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (5, 'Hero5', 2, 2, 2, 1);
-- NULL gender, Blue skin (Excluded by INNER JOIN / WHERE on gender)
INSERT INTO superhero (id, superhero_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id) VALUES (6, 'Hero6', NULL, 2, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.colour = 'Blue' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T2.gender = 'Female';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.colour = 'Blue' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.gender_id) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.gender_id = (SELECT id FROM gender WHERE gender = 'Female');

/*
Prediction Result:
(50.0,)
*/