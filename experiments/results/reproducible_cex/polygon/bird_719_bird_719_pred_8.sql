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
INSERT INTO "alignment" ("id", "alignment") VALUES (23, 'Super Strength46');
INSERT INTO "alignment" ("id", "alignment") VALUES (36, 'Super Strength46');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (25, 'Super Strength46');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, 'Super Strength46');
INSERT INTO "colour" ("id", "colour") VALUES (37, 'Super Strength46');
INSERT INTO "colour" ("id", "colour") VALUES (39, 'Super Strength46');
INSERT INTO "gender" ("id", "gender") VALUES (27, 'Super Strength46');
INSERT INTO "gender" ("id", "gender") VALUES (26, 'Super Strength46');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, 'Super Strength46');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (28, 'Super Strength46');
INSERT INTO "race" ("id", "race") VALUES (41, 'Super Strength46');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (29, 36, NULL, 27, 37, 28, 41, NULL, 'Super Strength46', 'Super Strength46', 46, 46);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (46, 36, 37, NULL, 39, 40, 41, NULL, 'Super Strength43', 'Super Strength44', 201, 45);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (25, NULL, 46);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (25, 46, 46);
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'Super Strength');
INSERT INTO "superpower" ("id", "power_name") VALUES (30, 'Super Strength');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (46, 31);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (46, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T3.power_name = 'Super Strength' AND T1.height_cm > 200;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "superhero"."id") FROM "superhero" INNER JOIN "hero_power" ON "superhero"."id" = "hero_power"."hero_id" INNER JOIN "superpower" ON "hero_power"."power_id" = "superpower"."id" WHERE "superpower"."power_name" = 'Super Strength' AND "superhero"."height_cm" > 200;

/*
Prediction Result:
(1,)
*/