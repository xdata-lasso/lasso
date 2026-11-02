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
INSERT INTO "alignment" ("id", "alignment") VALUES (32, 'Gold50');
INSERT INTO "alignment" ("id", "alignment") VALUES (41, 'Gold50');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (25, 'Gold50');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, 'Gold50');
INSERT INTO "colour" ("id", "colour") VALUES (49, 'Gold');
INSERT INTO "colour" ("id", "colour") VALUES (50, 'Gold');
INSERT INTO "gender" ("id", "gender") VALUES (33, 'Gold50');
INSERT INTO "gender" ("id", "gender") VALUES (42, 'Gold50');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (34, 'Gold50');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (43, 'Gold50');
INSERT INTO "race" ("id", "race") VALUES (35, 'Gold50');
INSERT INTO "race" ("id", "race") VALUES (44, 'Gold50');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (31, 32, 50, 33, 49, 34, 35, 49, 'Gold36', 'Gold37', 38, 39);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (40, 41, 50, 42, 50, 43, 44, 49, 'Gold45', 'Gold46', 47, 48);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (24, 40, 50);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (24, 40, 50);
INSERT INTO "superpower" ("id", "power_name") VALUES (26, 'Gold50');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (40, 26);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (40, 26);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T3.colour = 'Gold';

/*
Gold Result:
('Gold',)
('Gold',)
*/

-- Prediction Query
SELECT DISTINCT "colour"."colour" FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id" WHERE "superhero"."skin_colour_id" IN (SELECT "id" FROM "colour" WHERE "colour" = 'Gold');

/*
Prediction Result:
('Gold',)
*/