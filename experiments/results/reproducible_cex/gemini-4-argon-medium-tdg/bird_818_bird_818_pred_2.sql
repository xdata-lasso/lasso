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
INSERT INTO alignment (id, alignment) VALUES (1, 'Bad');
INSERT INTO alignment (id, alignment) VALUES (2, 'Good');
INSERT INTO alignment (id, alignment) VALUES (3, 'Neutral');
INSERT INTO gender (id, gender) VALUES (1, 'Female');
INSERT INTO gender (id, gender) VALUES (2, 'Male');
INSERT INTO gender (id, gender) VALUES (3, 'N/A');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (1, 'Hero1', 'Name1', 1, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (2, 'Hero2', 'Name2', 2, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (3, 'Hero3', 'Name3', 3, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (4, 'Hero4', 'Name4', 1, 2);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (5, 'Hero5', 'Name5', 2, 2);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (6, 'Hero6', 'Name6', 1, 3);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (7, 'Hero7', 'Name7', NULL, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, alignment_id) VALUES (8, 'Hero8', 'Name8', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Bad';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(gender_id = 2) AS REAL) * 100 / COUNT(alignment_id) FROM superhero WHERE alignment_id = 2;

/*
Prediction Result:
(50.0,)
*/