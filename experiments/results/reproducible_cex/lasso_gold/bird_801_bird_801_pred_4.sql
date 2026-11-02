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
INSERT INTO "alignment" ("id", "alignment") VALUES (1001, 'purpose');
INSERT INTO "alignment" ("id", "alignment") VALUES (1002, 'brother');
INSERT INTO "colour" ("id", "colour") VALUES (1003, 'ago');
INSERT INTO "colour" ("id", "colour") VALUES (1004, 'site');
INSERT INTO "colour" ("id", "colour") VALUES (1013, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1015, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1005, 'Female');
INSERT INTO "gender" ("id", "gender") VALUES (1006, 'Male');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1007, 'Daniel Doyle');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1008, 'Stephanie Miller');
INSERT INTO "race" ("id", "race") VALUES (1009, 'knowledge');
INSERT INTO "race" ("id", "race") VALUES (1010, 'almost');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1011, 'Daniel Wagner', 'Connie Lawrence', 1005, 1003, 1013, 1015, 1009, 1007, 1001, 1017, 1019);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1012, 'Cristian Santos', 'Abigail Shaffer', 1006, 1003, 1013, 1015, 1009, 1007, 1001, 1040.0, 1044.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.gender = 'Male' THEN T1.id ELSE NULL END) AS REAL) / COUNT(CASE WHEN T2.gender = 'Female' THEN T1.id ELSE NULL END) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN gender_id = 1 THEN 1 ELSE 0 END) * 1.0) / SUM(CASE WHEN gender_id = 2 THEN 1 ELSE 0 END) AS ratio FROM superhero;

/*
Prediction Result:
(None,)
*/