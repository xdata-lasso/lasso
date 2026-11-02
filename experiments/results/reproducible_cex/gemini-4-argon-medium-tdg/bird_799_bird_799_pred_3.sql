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
-- Comprehensive dataset: tests multiple heroes for publisher 1, boundary publisher IDs (0, 2), NULL foreign keys, NULL attributes, and wrong join conditions (e.g., T1.id = T2.id).
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Zero Comics');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'ABC Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Dark Horse Comics');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'DC Comics');
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO gender (id, gender) VALUES (2, 'Female');
INSERT INTO colour (id, colour) VALUES (1, 'Blue');
INSERT INTO colour (id, colour) VALUES (2, 'Black');
INSERT INTO race (id, race) VALUES (1, 'Human');
INSERT INTO race (id, race) VALUES (2, 'Mutant');
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO alignment (id, alignment) VALUES (2, 'Bad');
-- Hero 1 has id=1, but belongs to publisher 2 (kills mutants filtering on T1.id = 1 or joining T1.id = T2.id)
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Hero One', 'One Smith', 1, 1, 1, 1, 1, 2, 1, 180, 80);
-- Hero 2 and 3 belong to publisher 1 (kills COUNT(DISTINCT T1.publisher_id) or COUNT(DISTINCT T2.id))
-- Hero 2 has NULL superhero_name and full_name (kills COUNT(T1.superhero_name))
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, NULL, NULL, 2, 2, 2, 2, 2, 1, 2, 170, 65);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Hero Three', 'Three Jones', 2, 2, 2, 2, 2, 1, 2, 190, 90);
-- Hero 4 has publisher_id = 0 (kills T2.id <= 1 or T2.id < 1)
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (4, 'Hero Four', 'Four Brown', 1, 1, 1, 1, 1, 0, 1, 175, 75);
-- Hero 5 has publisher_id = NULL (kills LEFT JOIN mutants without proper WHERE filtering)
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (5, 'Hero Five', 'Five Davis', 1, 1, 1, 1, 1, NULL, 1, 185, 85);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.id = 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero WHERE publisher_id IS NULL;

/*
Prediction Result:
(1,)
*/