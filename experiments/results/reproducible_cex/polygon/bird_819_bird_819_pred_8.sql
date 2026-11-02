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
INSERT INTO "alignment" ("id", "alignment") VALUES (28, '21');
INSERT INTO "alignment" ("id", "alignment") VALUES (18, '21');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (20, '21');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (19, '21');
INSERT INTO "colour" ("id", "colour") VALUES (22, '48');
INSERT INTO "colour" ("id", "colour") VALUES (21, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (30, '21');
INSERT INTO "gender" ("id", "gender") VALUES (23, '21');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (33, '21');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (24, '21');
INSERT INTO "race" ("id", "race") VALUES (25, '21');
INSERT INTO "race" ("id", "race") VALUES (35, '21');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (27, 28, 21, 30, 21, 33, 35, 22, '44', '45', 46, 47);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (26, NULL, 22, NULL, NULL, NULL, NULL, NULL, '50', NULL, NULL, 53);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (20, 27, 21);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (20, 27, 21);
INSERT INTO "superpower" ("id", "power_name") VALUES (39, '21');
INSERT INTO "superpower" ("id", "power_name") VALUES (38, '21');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (27, 38);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (27, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T2.id = 7 THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.id = 1 THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.weight_kg = 0 OR T1.weight_kg IS NULL;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN "colour"."id" = 7 THEN 1 ELSE NULL END) - COUNT(CASE WHEN "colour"."id" = 1 THEN 1 ELSE NULL END) FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id" WHERE "superhero"."weight_kg" = 0 OR "superhero"."weight_kg" IS NULL;

/*
Prediction Result:
(0,)
*/