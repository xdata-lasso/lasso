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
INSERT INTO "alignment" ("id", "alignment") VALUES (17, 'Female23');
INSERT INTO "alignment" ("id", "alignment") VALUES (16, 'Female23');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (19, 'Female23');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (18, 'Female23');
INSERT INTO "colour" ("id", "colour") VALUES (21, 'Female23');
INSERT INTO "colour" ("id", "colour") VALUES (20, 'Female23');
INSERT INTO "gender" ("id", "gender") VALUES (23, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (22, 'Female23');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Female23');
INSERT INTO "race" ("id", "race") VALUES (25, 'Female23');
INSERT INTO "race" ("id", "race") VALUES (24, 'Female23');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (27, NULL, NULL, 23, NULL, 31, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Female23', 'Female23', 23, 23);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (18, 26, 23);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (18, 26, 23);
INSERT INTO "superpower" ("id", "power_name") VALUES (34, 'Female23');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (26, 34);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (26, 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.gender = 'Male' THEN T1.id ELSE NULL END) AS REAL) / COUNT(CASE WHEN T2.gender = 'Female' THEN T1.id ELSE NULL END) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "gender"."gender" = 'Female' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN "gender"."gender" = 'Male' THEN 1 ELSE 0 END) AS ratio FROM "superhero" INNER JOIN "gender" ON "superhero"."gender_id" = "gender"."id";

/*
Prediction Result:
(0.0,)
*/