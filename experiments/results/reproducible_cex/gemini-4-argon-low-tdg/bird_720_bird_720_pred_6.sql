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
-- Tests exact boundary conditions (15 vs 16) and GROUP BY full_name vs GROUP BY id.
-- Hero 1 has 15 powers (should be excluded, kills >= 15 and > 14 mutants).
-- Hero 2 has 16 powers (should be included, kills > 16 and = 15 mutants).
-- Heroes 3 and 4 share the same full_name ('Bruce Wayne') and have 8 powers each, totaling 16 (should be included, kills GROUP BY T1.id or GROUP BY T1.superhero_name mutants).
INSERT INTO superpower (id, power_name) VALUES (1, 'Power 1');
INSERT INTO superpower (id, power_name) VALUES (2, 'Power 2');
INSERT INTO superpower (id, power_name) VALUES (3, 'Power 3');
INSERT INTO superpower (id, power_name) VALUES (4, 'Power 4');
INSERT INTO superpower (id, power_name) VALUES (5, 'Power 5');
INSERT INTO superpower (id, power_name) VALUES (6, 'Power 6');
INSERT INTO superpower (id, power_name) VALUES (7, 'Power 7');
INSERT INTO superpower (id, power_name) VALUES (8, 'Power 8');
INSERT INTO superpower (id, power_name) VALUES (9, 'Power 9');
INSERT INTO superpower (id, power_name) VALUES (10, 'Power 10');
INSERT INTO superpower (id, power_name) VALUES (11, 'Power 11');
INSERT INTO superpower (id, power_name) VALUES (12, 'Power 12');
INSERT INTO superpower (id, power_name) VALUES (13, 'Power 13');
INSERT INTO superpower (id, power_name) VALUES (14, 'Power 14');
INSERT INTO superpower (id, power_name) VALUES (15, 'Power 15');
INSERT INTO superpower (id, power_name) VALUES (16, 'Power 16');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (1, 'Hero_15', 'Clark Kent');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (2, 'Hero_16', 'Diana Prince');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (3, 'Batman_1', 'Bruce Wayne');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (4, 'Batman_2', 'Bruce Wayne');
-- 15 powers for Hero 1
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 2);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 3);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 4);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 5);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 6);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 7);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 8);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 9);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 10);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 11);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 12);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 13);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 14);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 15);
-- 16 powers for Hero 2
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 2);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 3);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 4);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 5);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 6);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 7);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 8);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 9);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 10);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 11);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 12);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 13);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 14);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 15);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 16);
-- 8 powers for Hero 3 ('Bruce Wayne')
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 2);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 3);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 4);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 5);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 6);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 7);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 8);
-- 8 powers for Hero 4 ('Bruce Wayne')
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 9);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 10);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 11);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 12);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 13);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 14);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 15);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T2.power_id) > 15;

/*
Gold Result:
('Bruce Wayne',)
('Diana Prince',)
*/

-- Prediction Query
SELECT s.full_name FROM superhero AS s JOIN hero_power AS hp ON s.id = hp.hero_id GROUP BY s.id HAVING COUNT(hp.power_id) > 15;

/*
Prediction Result:
('Diana Prince',)
*/