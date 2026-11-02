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
-- Tests INNER JOIN vs LEFT JOIN on race_id, and INNER JOIN vs RIGHT JOIN on hero_attribute.
-- The highest attribute belongs to a hero with NULL race_id, and another high attribute has a NULL hero_id. Both must be excluded by INNER JOIN.
INSERT INTO race (id, race) VALUES (10, 'Human');
INSERT INTO race (id, race) VALUES (20, 'Android');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Speed');
INSERT INTO superhero (id, superhero_name, race_id) VALUES (1, 'NoRaceHero', NULL);
INSERT INTO superhero (id, superhero_name, race_id) VALUES (2, 'ValidHero', 10);
INSERT INTO superhero (id, superhero_name, race_id) VALUES (3, 'NoAttributeHero', 20);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 1, 999);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (NULL, 1, 888);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN race AS T3 ON T1.race_id = T3.id ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Human',)
*/

-- Prediction Query
SELECT race.race FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN race ON superhero.race_id = race.id WHERE hero_attribute.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Prediction Result:
*/