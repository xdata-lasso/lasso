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
INSERT INTO "alignment" ("id", "alignment") VALUES (57, 'Male52');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Male52');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Male52');
INSERT INTO "colour" ("id", "colour") VALUES (52, 'Male52');
INSERT INTO "gender" ("id", "gender") VALUES (61, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Male52');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Male52');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (53, 'Male52');
INSERT INTO "race" ("id", "race") VALUES (58, 'Male52');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (51, 57, 52, 61, 52, 53, 58, 52, NULL, 'Male54', 55, 121);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (56, 57, 52, 61, 52, 53, 58, 52, NULL, NULL, 60, 80);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (NULL, 56, 52);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, 56, 52);
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Male52');
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'Male52');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (56, 32);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (51, 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('Male54',)
(None,)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);

/*
Prediction Result:
(None,)
(None,)
*/