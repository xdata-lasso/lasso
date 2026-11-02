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
INSERT INTO "alignment" ("id", "alignment") VALUES (1034, 'win');
INSERT INTO "alignment" ("id", "alignment") VALUES (1045, 'top');
INSERT INTO "alignment" ("id", "alignment") VALUES (1056, 'prove');
INSERT INTO "colour" ("id", "colour") VALUES (1035, 'human');
INSERT INTO "colour" ("id", "colour") VALUES (1046, 'early');
INSERT INTO "colour" ("id", "colour") VALUES (1057, 'Congress');
INSERT INTO "colour" ("id", "colour") VALUES (1041, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1042, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1052, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1053, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1063, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1064, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1036, 'bar');
INSERT INTO "gender" ("id", "gender") VALUES (1047, 'trial');
INSERT INTO "gender" ("id", "gender") VALUES (1058, 'none');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1037, 'Sandra Montgomery');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1048, 'Donald Reid');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1059, 'Carla Gray');
INSERT INTO "race" ("id", "race") VALUES (1038, 'training');
INSERT INTO "race" ("id", "race") VALUES (1049, 'his');
INSERT INTO "race" ("id", "race") VALUES (1060, 'wish');
INSERT INTO "superpower" ("id", "power_name") VALUES (1039, 'Corey Jones');
INSERT INTO "superpower" ("id", "power_name") VALUES (1050, 'Henry Santiago');
INSERT INTO "superpower" ("id", "power_name") VALUES (1061, 'Kristin Cohen');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1040, 'Amazo', 'Patricia Galloway', 1036, 1035, 1041, 1042, 1038, 1037, 1034, 1043, 1044);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1051, 'Amazo', 'Melinda Jones', 1047, 1046, 1052, 1053, 1049, 1048, 1045, 1054, 1055);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1062, 'Amazo', 'Patty Perez', 1058, 1057, 1063, 1064, 1060, 1059, 1056, 1065, 1066);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1040, 1039);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1051, NULL);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1062, 1061);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.power_id) FROM hero_power AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id WHERE T2.superhero_name = 'Amazo';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(power_id) FROM hero_power WHERE hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Amazo');

/*
Prediction Result:
(1,)
*/