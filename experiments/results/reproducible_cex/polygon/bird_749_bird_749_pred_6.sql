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
INSERT INTO "alignment" ("id", "alignment") VALUES (24, 'Deathlok42');
INSERT INTO "alignment" ("id", "alignment") VALUES (38, 'Deathlok42');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (25, 'Deathlok42');
INSERT INTO "colour" ("id", "colour") VALUES (42, 'Deathlok42');
INSERT INTO "gender" ("id", "gender") VALUES (39, 'Deathlok42');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (26, 'Deathlok42');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, 'Deathlok42');
INSERT INTO "race" ("id", "race") VALUES (27, 'Deathlok42');
INSERT INTO "race" ("id", "race") VALUES (41, 'Deathlok42');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (46, 38, 42, 39, 42, 40, 41, 42, 'Deathlok', 'Deathlok43', 44, 45);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Deathlok42', 'Deathlok42', 42, 42);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (25, 28, 42);
INSERT INTO "superpower" ("id", "power_name") VALUES (30, NULL);
INSERT INTO "superpower" ("id", "power_name") VALUES (29, 'Deathlok42');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (46, 30);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (46, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.superhero_name = 'Deathlok';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "superpower"."power_name" FROM "superhero" INNER JOIN "hero_power" ON "superhero"."id" = "hero_power"."hero_id" INNER JOIN "superpower" ON "hero_power"."power_id" = "superpower"."id" WHERE "superhero"."superhero_name" = 'Deathlok';

/*
Prediction Result:
(None,)
*/