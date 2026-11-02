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
INSERT INTO "alignment" ("id", "alignment") VALUES (1001, 'purpose');
INSERT INTO "alignment" ("id", "alignment") VALUES (1002, 'brother');
INSERT INTO "alignment" ("id", "alignment") VALUES (1003, 'ago');
INSERT INTO "alignment" ("id", "alignment") VALUES (1004, 'site');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1005, 'Speed');
INSERT INTO "colour" ("id", "colour") VALUES (1006, 'face');
INSERT INTO "colour" ("id", "colour") VALUES (1007, 'election');
INSERT INTO "colour" ("id", "colour") VALUES (1008, 'dog');
INSERT INTO "colour" ("id", "colour") VALUES (1009, 'chair');
INSERT INTO "colour" ("id", "colour") VALUES (1026, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1030, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1010, 'since');
INSERT INTO "gender" ("id", "gender") VALUES (1011, 'blue');
INSERT INTO "gender" ("id", "gender") VALUES (1012, 'require');
INSERT INTO "gender" ("id", "gender") VALUES (1013, 'sit');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1014, 'Angie Henderson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1015, 'Daniel Wagner');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1016, 'Cristian Santos');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1017, 'Connie Lawrence');
INSERT INTO "race" ("id", "race") VALUES (1018, 'table');
INSERT INTO "race" ("id", "race") VALUES (1019, 'true');
INSERT INTO "race" ("id", "race") VALUES (1020, 'according');
INSERT INTO "race" ("id", "race") VALUES (1021, 'song');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1022, 'Melissa Peterson', 'Valerie Gray', 1010, 1006, 1026, 1030, 1018, 1014, 1001, 1034, 1038);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1023, 'Tyler Rogers', 'Sandra Montgomery', 1010, 1006, 1026, 1030, 1018, 1014, 1001, 1057.0, 1063.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1024, 'Brent Abbott', 'Laura Bush', 1010, 1006, 1026, 1030, 1018, 1014, 1001, 1080.0, 1088.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1025, 'Renee Blair', 'Darren Roberts', 1010, 1006, 1026, 1030, 1018, 1014, 1001, 1103.0, 1113.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1022, 1005, 1045);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1022, 1005, 1052.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1022, 1005, 1059.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1022, 1005, 1066.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.superhero_name) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T2.attribute_name = 'Speed' ORDER BY T1.attribute_value DESC, T1.hero_id NULLS LAST, T1.attribute_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(hero_attribute.hero_id) FROM hero_attribute INNER JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Speed' AND hero_attribute.attribute_value = 100;

/*
Prediction Result:
(0,)
*/