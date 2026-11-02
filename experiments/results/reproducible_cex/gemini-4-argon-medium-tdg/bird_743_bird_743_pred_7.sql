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
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'DC Comics');
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (1, 'Hero1', 1, 1);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (2, 'Hero2', 1, 1);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (3, 'Hero3', 2, 1);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (4, 'Hero4', 1, 2);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (5, 'Hero5', 1, 2);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (6, 'Hero6', 2, 2);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (7, 'Hero7', 2, 2);
INSERT INTO superhero (id, superhero_name, publisher_id, alignment_id) VALUES (8, 'Hero8', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(COUNT(*) AS REAL) * 100 / (SELECT COUNT(*) FROM superhero)), CAST(SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS REAL) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T3.id = T1.alignment_id WHERE T3.alignment = 'Bad';

/*
Gold Result:
(37.5, 2.0)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.alignment = 'Bad' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id), SUM(CASE WHEN T2.alignment = 'Bad' THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN publisher AS T3 ON T1.publisher_id = T3.id WHERE T3.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(50.0, 2)
*/