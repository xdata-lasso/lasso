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
-- Tests:
-- 1. COUNT(superhero_name) vs COUNT(*) or COUNT(T3.id) by including a superhero with a NULL superhero_name.
-- 2. COUNT(superhero_name) vs COUNT(DISTINCT superhero_name) by including duplicate superhero_names ('Flash') for different heroes, and duplicate hero_attribute entries for the same hero.
-- 3. WHERE T2.attribute_name = 'Speed' vs missing WHERE, or LIKE '%Speed%', or case-sensitivity ('speed'), or other attributes ('Strength').
-- 4. INNER JOIN vs LEFT/RIGHT JOIN by including unlinked attributes, unlinked superheroes, and hero_attributes with NULL foreign keys.
-- 5. Presence of GROUP BY mutants (which would return the count of a single group due to LIMIT 1 instead of the total count of 3).
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (3, 'speed');
INSERT INTO attribute (id, attribute_name) VALUES (4, 'Super Speed');
INSERT INTO attribute (id, attribute_name) VALUES (5, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (6, 'Speed');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (1, 'Flash', 'Barry Allen');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (2, 'Flash', 'Wally West');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (3, NULL, 'Unknown Hero');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (4, 'Superman', 'Clark Kent');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (5, 'Unlinked Hero', 'No Attributes');
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 1, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 6, 95);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 90);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 1, 80);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 2, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 3, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 4, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 5, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (NULL, 1, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, NULL, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.superhero_name) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T2.attribute_name = 'Speed' ORDER BY T1.attribute_value DESC, T1.hero_id NULLS LAST, T1.attribute_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(T1.id) FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id WHERE T1.attribute_name = 'Speed' AND T2.attribute_value = 100;

/*
Prediction Result:
(2,)
*/