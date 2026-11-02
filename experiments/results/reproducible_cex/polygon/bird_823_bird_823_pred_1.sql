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
INSERT INTO "alignment" ("id", "alignment") VALUES (52, 'Female55');
INSERT INTO "alignment" ("id", "alignment") VALUES (30, 'Female55');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, 'Female55');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (23, 'Female55');
INSERT INTO "colour" ("id", "colour") VALUES (53, 'Female55');
INSERT INTO "colour" ("id", "colour") VALUES (55, 'Female55');
INSERT INTO "gender" ("id", "gender") VALUES (60, 'Female');
INSERT INTO "gender" ("id", "gender") VALUES (25, 'Marvel Comics46');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (27, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (26, 'Female55');
INSERT INTO "race" ("id", "race") VALUES (54, 'Female55');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (29, 30, 55, 25, 53, NULL, NULL, NULL, NULL, 'Female41', 42, 43);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (51, 52, 53, 60, 55, 27, 54, 55, 'Marvel Comics56', 'Female57', 58, 59);
INSERT INTO "superpower" ("id", "power_name") VALUES (34, 'Female55');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN publisher ON superhero.publisher_id = publisher.id WHERE gender.gender = 'Female' AND publisher.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(1,)
*/