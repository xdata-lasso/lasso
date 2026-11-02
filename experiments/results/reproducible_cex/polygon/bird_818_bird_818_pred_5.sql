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
INSERT INTO "alignment" ("id", "alignment") VALUES (33, 'Bad');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, NULL);
INSERT INTO "attribute" ("id", "attribute_name") VALUES (23, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (26, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (25, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (27, 'Female61');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (29, NULL);
INSERT INTO "publisher" ("id", "publisher_name") VALUES (28, NULL);
INSERT INTO "race" ("id", "race") VALUES (31, NULL);
INSERT INTO "race" ("id", "race") VALUES (30, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (45, 33, NULL, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (32, 33, NULL, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (24, 32, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (24, 32, NULL);
INSERT INTO "superpower" ("id", "power_name") VALUES (40, NULL);
INSERT INTO "superpower" ("id", "power_name") VALUES (39, NULL);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (NULL, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Bad';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.id = 2 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T1.alignment_id = 2;

/*
Prediction Result:
(None,)
*/