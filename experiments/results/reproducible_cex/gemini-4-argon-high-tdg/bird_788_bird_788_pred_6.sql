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
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO gender (id, gender) VALUES (2, 'Female');
INSERT INTO gender (id, gender) VALUES (3, 'Non-Binary');
INSERT INTO publisher (id, publisher_name) VALUES (10, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (20, 'DC Comics');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (101, 'Spider-Woman', 'Jessica Drew', 2, 10, 178, 59);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (102, NULL, NULL, 2, 10, NULL, NULL);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (103, 'Spider-Woman', 'Selina Kyle', 2, 20, 170, 57);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (104, 'Wanderer', 'Jane Doe', 2, NULL, 165, 55);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (105, 'Iron Man', 'Tony Stark', 1, 10, 185, 102);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (106, 'Thor', 'Thor Odinson', 1, 10, 198, 290);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (107, 'Hulk', 'Bruce Banner', 1, 10, 244, 635);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (108, 'Snowflake', 'Unknown', 3, 10, 170, 60);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, publisher_id, height_cm, weight_kg) VALUES (109, 'Mystery', 'Unknown', NULL, 10, 180, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T3.gender = 'Female';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN gender.gender = 'Female' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM superhero INNER JOIN gender ON superhero.gender_id = gender.id INNER JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(33.333333333333336,)
*/