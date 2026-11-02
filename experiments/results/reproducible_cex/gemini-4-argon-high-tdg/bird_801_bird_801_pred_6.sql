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
-- DATASET 2
INSERT INTO gender (id, gender) VALUES (1, 'N/A');
INSERT INTO gender (id, gender) VALUES (2, 'Male');
INSERT INTO gender (id, gender) VALUES (3, 'Female');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (1, 'Construct A', 'None', 1, 210, 400);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (2, 'Construct B', 'None', 1, 220, 450);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (10, 'Vanguard', 'Marcus Vance', 2, 188, 92);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (20, 'Sentinel', 'David Chen', 2, 175, 78);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (30, 'Apex', 'Liam OConnor', 2, 182, 84);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (40, 'Titan', 'Carlos Ruiz', 2, 195, 110);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (50, 'Cipher', 'Noah Kim', 2, 173, 68);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (60, 'Blaze', 'Omar Farooq', 2, 180, 81);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (70, 'Frost', 'Ivan Petrov', 2, 190, 95);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (80, 'Nova', 'Elena Rostova', 3, 172, 62);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (90, 'mirage', 'aria Montgomery', 3, 165, 55);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, height_cm, weight_kg) VALUES (100, 'Valyrie', 'Freya Lind', 3, 181, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.gender = 'Male' THEN T1.id ELSE NULL END) AS REAL) / COUNT(CASE WHEN T2.gender = 'Female' THEN T1.id ELSE NULL END) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id;

/*
Gold Result:
(2.3333333333333335,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN gender_id = 1 THEN 1 ELSE 0 END) AS REAL) * 1.0 / SUM(CASE WHEN gender_id = 2 THEN 1 ELSE 0 END) AS male_female_ratio FROM superhero;

/*
Prediction Result:
(0.2857142857142857,)
*/