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
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO alignment (id, alignment) VALUES (2, 'Bad');
INSERT INTO alignment (id, alignment) VALUES (3, 'Neutral');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'DC Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'Dark Horse Comics');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Strength');
INSERT INTO superpower (id, power_name) VALUES (1, 'Flight');
INSERT INTO superpower (id, power_name) VALUES (2, 'Telepathy');
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Venom', 'Eddie Brock', 2, 2, 191, 118);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'Joker', 'Jack Napier', 1, 2, 196, 87);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Spider-Man', 'Peter Parker', 2, 1, 178, 76);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (4, 'Rogue Villain', 'Unknown', NULL, 2, 180, 80);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (5, 'Mystery Marvel', 'Unknown', 2, NULL, 175, 70);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (6, 'Hellboy', 'Anung Un Rama', 3, 3, 259, 158);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, alignment_id, height_cm, weight_kg) VALUES (7, 'Superman', 'Clark Kent', 1, 1, 191, 101);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 1, 75);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 2, 95);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(COUNT(*) AS REAL) * 100 / (SELECT COUNT(*) FROM superhero)), CAST(SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS REAL) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T3.id = T1.alignment_id WHERE T3.alignment = 'Bad';

/*
Gold Result:
(28.571428571428573, 1.0)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.alignment = 'Bad' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.id) AS "percentage", COUNT(CASE WHEN T1.alignment = 'Bad' AND T3.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS "number" FROM alignment AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.alignment_id INNER JOIN publisher AS T3 ON T3.id = T2.publisher_id;

/*
Prediction Result:
(40.0, 5)
*/