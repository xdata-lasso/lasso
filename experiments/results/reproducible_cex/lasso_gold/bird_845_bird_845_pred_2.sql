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
INSERT INTO "alignment" ("id", "alignment") VALUES (1031, 'drive');
INSERT INTO "alignment" ("id", "alignment") VALUES (1032, 'spring');
INSERT INTO "alignment" ("id", "alignment") VALUES (1033, 'figure');
INSERT INTO "colour" ("id", "colour") VALUES (1034, 'base');
INSERT INTO "colour" ("id", "colour") VALUES (1035, 'top');
INSERT INTO "colour" ("id", "colour") VALUES (1036, 'early');
INSERT INTO "colour" ("id", "colour") VALUES (1052, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1055, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1037, 'trial');
INSERT INTO "gender" ("id", "gender") VALUES (1038, 'blood');
INSERT INTO "gender" ("id", "gender") VALUES (1039, 'husband');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1040, 'Mark Diaz');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1041, 'Daniel Adams');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1042, 'Maria Lynch');
INSERT INTO "race" ("id", "race") VALUES (1043, 'Congress');
INSERT INTO "race" ("id", "race") VALUES (1044, 'none');
INSERT INTO "race" ("id", "race") VALUES (1045, 'shoulder');
INSERT INTO "superpower" ("id", "power_name") VALUES (1046, 'Joel Nelson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1047, 'Melissa Robinson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1048, 'Randy Brown');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1049, 'Renee Morales', 'Maria Thomas', 1037, 1034, 1052, 1055, 1043, 1040, 1031, 1, 1058);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1062, 'Renee Morales', 'Maria Thomas', 1037, 1034, 1052, 1055, 1043, 1040, 1031, 3, 1058);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1063, 'Renee Morales', 'Maria Thomas', 1037, 1034, 1052, 1055, 1043, 1040, 1031, 5, 1058);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1049, 1046);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1049, 1047);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1049, 1048);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1062, 1046);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1063, 1046);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm * 100 > (SELECT AVG(height_cm) FROM superhero) * 80;

/*
Gold Result:
('Joel Nelson',)
('Joel Nelson',)
*/

-- Prediction Query
SELECT DISTINCT "superpower"."power_name" FROM "superhero" INNER JOIN "hero_power" ON "superhero"."id" = "hero_power"."hero_id" INNER JOIN "superpower" ON "hero_power"."power_id" = "superpower"."id" WHERE "superhero"."height_cm" > (SELECT AVG("height_cm") * 0.8 FROM "superhero");

/*
Prediction Result:
('Joel Nelson',)
*/