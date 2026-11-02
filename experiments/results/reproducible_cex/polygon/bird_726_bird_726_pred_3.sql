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
INSERT INTO "alignment" ("id", "alignment") VALUES (36, 'Marvel Comics31');
INSERT INTO "alignment" ("id", "alignment") VALUES (30, 'Marvel Comics31');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (20, 'Marvel Comics31');
INSERT INTO "colour" ("id", "colour") VALUES (39, 'Marvel Comics31');
INSERT INTO "colour" ("id", "colour") VALUES (31, 'Marvel Comics31');
INSERT INTO "gender" ("id", "gender") VALUES (21, 'Marvel Comics31');
INSERT INTO "gender" ("id", "gender") VALUES (37, 'Marvel Comics31');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (43, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (34, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (22, 'Marvel Comics31');
INSERT INTO "race" ("id", "race") VALUES (38, 'Marvel Comics31');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (29, 30, 31, 37, 31, 34, 38, 39, 'Marvel Comics40', 'Marvel Comics40', 32, 33);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (35, 36, 31, 37, 31, 43, 38, 39, NULL, 'Marvel Comics40', 41, 42);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (20, 35, 31);
INSERT INTO "superpower" ("id", "power_name") VALUES (24, 'Marvel Comics31');
INSERT INTO "superpower" ("id", "power_name") VALUES (23, 'Marvel Comics31');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (35, 23);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (35, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Marvel Comics40',)
*/

-- Prediction Query
SELECT T1.superhero_name AS name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
(None,)
('Marvel Comics40',)
*/