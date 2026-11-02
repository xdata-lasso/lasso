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
-- Tests basic matching, non-overlapping IDs (kills wrong join key mutations), duplicate gender outputs (kills DISTINCT mutations), and string predicate filtering (kills LIKE/case/other power_name mutations).
INSERT INTO gender (id, gender) VALUES (10, 'Female');
INSERT INTO gender (id, gender) VALUES (20, 'Male');
INSERT INTO gender (id, gender) VALUES (30, 'Phoenix Force');
INSERT INTO superpower (id, power_name) VALUES (100, 'Phoenix Force');
INSERT INTO superpower (id, power_name) VALUES (200, 'Telepathy');
INSERT INTO superpower (id, power_name) VALUES (300, 'phoenix force');
INSERT INTO superpower (id, power_name) VALUES (400, 'Phoenix Force Unleashed');
INSERT INTO superhero (id, superhero_name, full_name, gender_id) VALUES (1, 'Jean Grey', 'Jean Grey', 10);
INSERT INTO superhero (id, superhero_name, full_name, gender_id) VALUES (2, 'Rachel Summers', 'Rachel Summers', 10);
INSERT INTO superhero (id, superhero_name, full_name, gender_id) VALUES (3, 'Cyclops', 'Scott Summers', 20);
INSERT INTO superhero (id, superhero_name, full_name, gender_id) VALUES (4, 'Phoenix', 'Phoenix Force', 20);
INSERT INTO hero_power (hero_id, power_id) VALUES (1, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 200);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 300);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.gender FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T3.power_name = 'Phoenix Force';

/*
Gold Result:
('Female',)
('Female',)
*/

-- Prediction Query
SELECT DISTINCT gender.gender FROM gender INNER JOIN superhero ON gender.id = superhero.gender_id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Phoenix Force';

/*
Prediction Result:
('Female',)
*/