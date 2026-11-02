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
INSERT INTO "alignment" ("id", "alignment") VALUES (24, 'Super Strength38');
INSERT INTO "alignment" ("id", "alignment") VALUES (23, 'Super Strength38');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (26, 'Super Strength38');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (25, 'Super Strength38');
INSERT INTO "colour" ("id", "colour") VALUES (38, 'Super Strength38');
INSERT INTO "colour" ("id", "colour") VALUES (41, 'Super Strength38');
INSERT INTO "gender" ("id", "gender") VALUES (27, 'Super Strength38');
INSERT INTO "gender" ("id", "gender") VALUES (37, 'Super Strength38');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (39, 'Super Strength38');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (28, 'Super Strength38');
INSERT INTO "race" ("id", "race") VALUES (40, 'Super Strength38');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (29, 23, NULL, 27, 38, 28, 40, 41, 'Super Strength38', 'Super Strength38', 38, 38);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (45, NULL, 38, 37, 38, 39, 40, 41, 'Super Strength42', 'Super Strength43', 201, 44);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (26, NULL, 38);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (25, 45, 38);
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'Super Strength');
INSERT INTO "superpower" ("id", "power_name") VALUES (30, 'Super Strength');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (45, 31);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (45, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T3.power_name = 'Super Strength' AND T1.height_cm > 200;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT hero_power.hero_id) AS tall_heroes_with_super_strength FROM superhero INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Super Strength' AND superhero.height_cm > 200;

/*
Prediction Result:
(1,)
*/