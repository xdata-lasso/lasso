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
-- Tests:
-- 1. Incorrect join condition (e.g., T1.id = T2.id or cross join)
-- 2. String matching mutations (case sensitivity 'neutral', prefix/suffix 'Neutrality', other columns having 'Neutral')
-- 3. Multiple alignment records with 'Neutral' (tests GROUP BY T2.id vs single aggregate result)
-- 4. Zero height_cm vs NULL height_cm
INSERT INTO alignment (id, alignment) VALUES (1, 'Neutral');
INSERT INTO alignment (id, alignment) VALUES (2, 'neutral');
INSERT INTO alignment (id, alignment) VALUES (3, 'Neutrality');
INSERT INTO alignment (id, alignment) VALUES (4, 'Good');
INSERT INTO alignment (id, alignment) VALUES (5, 'Neutral');
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (1, 'NotNeutralHero', 'Neutral', 4, 500, 100);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (2, 'LowercaseNeutral', 'John Doe', 2, 300, 80);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (3, 'LikeNeutral', 'Jane Doe', 3, 400, 70);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (4, 'TrueNeutral1', 'Hero A', 1, 0, 60);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (5, 'TrueNeutral2', 'Hero B', 1, 150, 65);
INSERT INTO superhero (id, superhero_name, full_name, alignment_id, height_cm, weight_kg) VALUES (6, 'TrueNeutral3', 'Hero C', 5, 210, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.height_cm) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id WHERE T2.alignment = 'Neutral';

/*
Gold Result:
(120.0,)
*/

-- Prediction Query
SELECT AVG(T1.height_cm) FROM superhero AS T1 LEFT JOIN alignment AS T2 ON T1.alignment_id = T2.id WHERE LOWER(T2.alignment) = 'neutral';

/*
Prediction Result:
(165.0,)
*/