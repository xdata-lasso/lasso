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
-- Tests COUNT(T2.power_id) vs COUNT(*) vs COUNT(DISTINCT T2.power_id).
-- Hero 1 has 16 rows in hero_power, but only 1 distinct power_id (kills COUNT(DISTINCT T2.power_id) mutants).
-- Hero 2 has 15 rows with valid power_id and 2 rows with NULL power_id (kills COUNT(*) and COUNT(T2.hero_id) mutants).
INSERT INTO superpower (id, power_name) VALUES (1, 'Super Strength');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (1, 'OneTrickPony', 'Barry Allen');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (2, 'NullPowerHero', 'Hal Jordan');
-- 16 duplicate power rows for Hero 1
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
-- 15 non-null power rows and 2 NULL power_id rows for Hero 2
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T2.power_id) > 15;

/*
Gold Result:
('Barry Allen',)
*/

-- Prediction Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T1.full_name) > 15;

/*
Prediction Result:
('Barry Allen',)
('Hal Jordan',)
*/