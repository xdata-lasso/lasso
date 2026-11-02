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
-- Comprehensive predicate, DISTINCT, NULL, and ID collision testing
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'DC Comics');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'Marvel Comics');
INSERT INTO gender (id, gender) VALUES (10, 'Female');
INSERT INTO gender (id, gender) VALUES (20, 'Male');
INSERT INTO gender (id, gender) VALUES (30, 'Female');
-- Valid matches (multiple heroes sharing the same publisher/gender to catch COUNT(DISTINCT T2.id) / COUNT(DISTINCT T3.id))
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (100, 'Storm', NULL, 10, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (101, 'Black Widow', 'Natasha Romanoff', 10, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (102, 'Captain Marvel', 'Carol Danvers', 30, 3);
-- Partial matches (catches OR vs AND, missing predicates, negation errors)
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (103, 'Iron Man', 'Tony Stark', 20, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (104, 'Wonder Woman', 'Diana Prince', 10, 2);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (105, 'Batman', 'Bruce Wayne', 20, 2);
-- NULL foreign keys (catches LEFT/RIGHT JOIN vs INNER JOIN and COUNT(*) vs COUNT(col) on outer joins)
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (106, 'Mystery Hero 1', 'Unknown', NULL, 1);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (107, 'Mystery Hero 2', 'Unknown', 10, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (108, 'Mystery Hero 3', 'Unknown', NULL, NULL);
-- Accidental ID collision traps (catches wrong join conditions like T1.id = T2.id or T2.id = T3.id)
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (1, 'Trap Hero 1', 'Trap', 20, 2);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id) VALUES (10, 'Trap Hero 2', 'Trap', 20, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS s JOIN publisher AS p ON s.publisher_id = p.id WHERE s.gender_id = (SELECT id FROM gender WHERE gender = 'Female') AND p.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(2,)
*/