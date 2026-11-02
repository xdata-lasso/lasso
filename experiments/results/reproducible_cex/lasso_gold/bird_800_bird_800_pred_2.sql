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
INSERT INTO "alignment" ("id", "alignment") VALUES (1057, 'away');
INSERT INTO "alignment" ("id", "alignment") VALUES (1067, 'stand');
INSERT INTO "colour" ("id", "colour") VALUES (1058, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1068, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1063, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1064, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1073, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1074, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1059, 'politics');
INSERT INTO "gender" ("id", "gender") VALUES (1069, 'arrive');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1060, 'Kimberly Sanchez');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1070, 'Andrew Stewart');
INSERT INTO "race" ("id", "race") VALUES (1061, 'maintain');
INSERT INTO "race" ("id", "race") VALUES (1071, 'executive');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1062, 'William Bowman', 'Melinda Cameron', 1059, 1058, 1063, 1064, 1061, 1060, 1057, 1065, 1066);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1072, NULL, 'Christy Porter', 1069, 1068, 1073, 1074, 1071, 1070, 1067, 1075, 1076);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.colour = 'Blue' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "colour"."colour" = 'Blue' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("superhero"."superhero_name") FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id";

/*
Prediction Result:
(200.0,)
*/