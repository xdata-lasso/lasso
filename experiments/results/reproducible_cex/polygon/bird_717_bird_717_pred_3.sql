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
INSERT INTO "alignment" ("id", "alignment") VALUES (28, '3-D Man36');
INSERT INTO "alignment" ("id", "alignment") VALUES (29, '3-D Man36');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, '3-D Man36');
INSERT INTO "colour" ("id", "colour") VALUES (37, '3-D Man36');
INSERT INTO "colour" ("id", "colour") VALUES (36, '3-D Man36');
INSERT INTO "gender" ("id", "gender") VALUES (31, '3-D Man36');
INSERT INTO "gender" ("id", "gender") VALUES (30, '3-D Man36');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (32, '3-D Man36');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (33, '3-D Man36');
INSERT INTO "race" ("id", "race") VALUES (35, '3-D Man36');
INSERT INTO "race" ("id", "race") VALUES (34, '3-D Man36');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (40, 28, 37, 30, 36, 32, 34, 36, '3-D Man', '3-D Man46', 47, 48);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (41, 29, 36, 31, 37, 33, 35, 37, '3-D Man', '3-D Man49', 50, 51);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 41, 36);
INSERT INTO "superpower" ("id", "power_name") VALUES (39, '3-D Man54');
INSERT INTO "superpower" ("id", "power_name") VALUES (38, '3-D Man54');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (40, 38);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (41, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.superhero_name = '3-D Man';

/*
Gold Result:
('3-D Man54',)
('3-D Man54',)
*/

-- Prediction Query
SELECT DISTINCT t3.power_name FROM superhero AS t1 INNER JOIN hero_power AS t2 ON t1.id = t2.hero_id INNER JOIN superpower AS t3 ON t2.power_id = t3.id WHERE t1.superhero_name = '3-D Man';

/*
Prediction Result:
('3-D Man54',)
*/