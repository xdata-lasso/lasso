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
-- Tests cardinality and duplicate handling: COUNT(T1.id) vs COUNT(DISTINCT T1.id), multiple powers per hero, and duplicate rows in hero_power.
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO superpower (id, power_name) VALUES (10, 'Agility');
INSERT INTO superpower (id, power_name) VALUES (20, 'Agility');
INSERT INTO superpower (id, power_name) VALUES (30, 'Strength');
-- Hero 1: Has Blue eyes and is linked to two different 'Agility' entries and a duplicate link, plus another power.
INSERT INTO superhero (id, superhero_name, eye_colour_id) VALUES (101, 'MultiAgilityHero', 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (101, 10);
INSERT INTO hero_power (hero_id, power_id) VALUES (101, 10);
INSERT INTO hero_power (hero_id, power_id) VALUES (101, 20);
INSERT INTO hero_power (hero_id, power_id) VALUES (101, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN colour AS T4 ON T1.eye_colour_id = T4.id WHERE T3.power_name = 'Agility' AND T4.colour = 'Blue';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) AS blueeyed_agility_heroes FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE colour.colour = 'Blue' AND superpower.power_name = 'Agility';

/*
Prediction Result:
(1,)
*/