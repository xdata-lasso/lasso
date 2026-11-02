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
INSERT INTO "alignment" ("id", "alignment") VALUES (1134, 'on');
INSERT INTO "alignment" ("id", "alignment") VALUES (1266, 'two');
INSERT INTO "colour" ("id", "colour") VALUES (1135, 'traditional');
INSERT INTO "colour" ("id", "colour") VALUES (1267, 'wind');
INSERT INTO "colour" ("id", "colour") VALUES (1153, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1157, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1285, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1289, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1136, 'yes');
INSERT INTO "gender" ("id", "gender") VALUES (1268, 'bag');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1137, 'Nathan Maldonado');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1269, 'Scott Pierce');
INSERT INTO "race" ("id", "race") VALUES (1138, 'not');
INSERT INTO "race" ("id", "race") VALUES (1270, 'apply');
INSERT INTO "superpower" ("id", "power_name") VALUES (1139, 'Patricia Peterson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1140, 'Christopher Smith');
INSERT INTO "superpower" ("id", "power_name") VALUES (1141, 'Michelle Stanton');
INSERT INTO "superpower" ("id", "power_name") VALUES (1142, 'Katie Rodriguez');
INSERT INTO "superpower" ("id", "power_name") VALUES (1271, 'Kimberly Smith');
INSERT INTO "superpower" ("id", "power_name") VALUES (1272, 'Paul Young');
INSERT INTO "superpower" ("id", "power_name") VALUES (1273, 'John Hancock');
INSERT INTO "superpower" ("id", "power_name") VALUES (1274, 'Carmen Smith');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1143, 'Sarah Romero', 'James Martin', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1170, 1174);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1144, 'Sarah Romero', 'Tammy Sellers', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1193.0, 1199.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1145, 'Sarah Romero', 'Katherine Rodriguez', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1216.0, 1224.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1146, 'Sarah Romero', 'William Roman', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1239.0, 1249.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1275, 'Timothy Glover', 'Michael Cross', 1268, 1267, 1285, 1289, 1270, 1269, 1266, 1302, 1306);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1276, 'Timothy Glover', 'Mary Tucker', 1268, 1267, 1285, 1289, 1270, 1269, 1266, 1325.0, 1331.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1277, 'Timothy Glover', 'Daniel Brown', 1268, 1267, 1285, 1289, 1270, 1269, 1266, 1348.0, 1356.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1278, 'Timothy Glover', 'Amy Edwards', 1268, 1267, 1285, 1289, 1270, 1269, 1266, 1371.0, 1381.0);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1143, 1139);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1275, NULL);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1276, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.superhero_name ORDER BY COUNT(T2.hero_id) DESC, T1.superhero_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Timothy Glover',)
*/

-- Prediction Query
SELECT T2.superhero_name FROM hero_power AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id GROUP BY T2.superhero_name ORDER BY COUNT(T1.power_id) DESC, T2.superhero_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Sarah Romero',)
*/