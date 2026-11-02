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
INSERT INTO "alignment" ("id", "alignment") VALUES (35, 'Human30');
INSERT INTO "alignment" ("id", "alignment") VALUES (36, 'Human30');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Human30');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Human30');
INSERT INTO "colour" ("id", "colour") VALUES (37, 'Human30');
INSERT INTO "colour" ("id", "colour") VALUES (30, 'Human55');
INSERT INTO "gender" ("id", "gender") VALUES (38, 'Human30');
INSERT INTO "gender" ("id", "gender") VALUES (39, 'Human30');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, 'Human30');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (41, 'Human30');
INSERT INTO "race" ("id", "race") VALUES (32, 'Human30');
INSERT INTO "race" ("id", "race") VALUES (31, 'Human');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (34, 35, 30, 38, 30, 40, 31, 37, 'Human47', 'Human48', 185, 49);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, 36, 37, 39, 30, 41, 31, 30, 'Human50', 'Human51', 185, 52);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 33, 30);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 33, 30);
INSERT INTO "superpower" ("id", "power_name") VALUES (42, 'Human30');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (33, 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('Human55',)
*/

-- Prediction Query
SELECT T3.colour FROM superhero AS T1 LEFT JOIN race AS T2 ON T1.race_id = T2.id LEFT JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Prediction Result:
('Human55',)
('Human55',)
*/