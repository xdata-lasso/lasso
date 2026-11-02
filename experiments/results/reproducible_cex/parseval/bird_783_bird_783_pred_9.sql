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
-- Inserting into table: colour --
INSERT INTO "colour" ("id", "colour") VALUES (1, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'col_761394');

INSERT INTO "colour" ("id", "colour") VALUES (5, '9n8');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'siie');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'ph2');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'ptt');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'zjo7wgxd5ysx');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'npi');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'v8u');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'yvkv42q7s');

INSERT INTO "colour" ("id", "colour") VALUES (11, '9n0jxfofwsz');

INSERT INTO "colour" ("id", "colour") VALUES (12, '5amsorlwyngc');

INSERT INTO "colour" ("id", "colour") VALUES (13, '521gwnlas6e');

INSERT INTO "colour" ("id", "colour") VALUES (14, 'awg96aqb0tbi');

INSERT INTO "colour" ("id", "colour") VALUES (15, 'c');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'a2ypuzhsrwbb', 'p6luhvdlttil', -2147483648, 5, 1, 1, -2147483648, -2147483648, -2147483648, 429706943, 462974032);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'klfa9000t', 'c4ecigce', -2147483648, 6, 5, 1, -2147483648, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'rqro', 'fqyp5s5bbp0', -2147483648, 5, 5, 1, -2147483648, -2147483648, -2147483648, 743312762, -1822992503);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, '1ryytoo', 'o9hl72kl', -2147483648, 6, 2, 1, -2147483648, -2147483648, -2147483648, -305670381, -1525670226);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'dwyrq13pyu78', '9', -2147483648, 5, 1, 1, -2147483648, -2147483648, -2147483648, 244829661, -1362461264);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'p5qi2rk', '9v', -2147483648, 6, 6, 1, -2147483648, -2147483648, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'gd', '1vy9uxj4', -2147483648, 2, 6, 1, -2147483648, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'nqcx5h', 'cprj', -2147483648, 3, 2, 1, -2147483648, -2147483648, -2147483648, -841004020, -361507387);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'kn6vc', '6ah', -2147483648, 2, 2, 1, -2147483648, -2147483648, -2147483648, -348113485, 138842628);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'xb72fxa7r', 'fdrz16n', -2147483648, 1, 5, 1, -2147483648, -2147483648, -2147483648, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'rg', 'd8y', -2147483648, 2, 1, 1, -2147483648, -2147483648, -2147483648, 1129658414, 1250290042);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'tsj3ayxp1q4', '01jh3den', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 357330522, -683007527);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, '5w1of7', 'pzo72ctdc', -2147483648, 2, 3, 1, -2147483648, -2147483648, -2147483648, 1303877941, -1284905200);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'q8qdjpe1', 'o22', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 2004147439, -691774480);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '5zi36c4bfkfo', 'c', -2147483648, 4, 2, 1, -2147483648, -2147483648, -2147483648, -406331049, -461418236);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'ztdg', '5i3', -2147483648, 7, 7, 1, -2147483648, -2147483648, -2147483648, -1405314653, 1816660482);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 's27p2r94gth2', 'najj', -2147483648, 8, 5, 1, -2147483648, -2147483648, -2147483648, -1351793914, 1919033056);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'e578', 'fvy', -2147483648, 9, 6, 1, -2147483648, -2147483648, -2147483648, -451030047, -2052653308);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'pmaus3auvmkr', 'pdjwzw5chn9', -2147483648, 10, 9, 1, -2147483648, -2147483648, -2147483648, 101754718, 628082526);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'b', 'q0k32od', -2147483648, 11, 8, 1, -2147483648, -2147483648, -2147483648, -613916489, 2061558815);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'rhizgk1yoey', 'o6l0hdt6fu', -2147483648, 12, 10, 1, -2147483648, -2147483648, -2147483648, -477129795, -1418927432);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'ii1z5n', 'xih662q2xly', -2147483648, 13, 6, 1, -2147483648, -2147483648, -2147483648, 412199481, 727608179);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'j', '9td8n5w', -2147483648, 14, 7, 1, -2147483648, -2147483648, -2147483648, -1988582944, -794767771);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'bd0w9603v', 'xw1rxe9', -2147483648, 15, 14, 1, -2147483648, -2147483648, -2147483648, -505019168, 1968783602);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T3.colour = 'Gold';

/*
Gold Result:
('9n8',)
('siie',)
('9n8',)
('siie',)
('9n8',)
('siie',)
('col_761394',)
('Gold',)
('col_761394',)
('Gold',)
('col_761394',)
('Gold',)
('col_761394',)
('ph2',)
('ptt',)
('zjo7wgxd5ysx',)
('npi',)
('v8u',)
('yvkv42q7s',)
('9n0jxfofwsz',)
('5amsorlwyngc',)
('521gwnlas6e',)
('awg96aqb0tbi',)
('c',)
*/

-- Prediction Query
SELECT DISTINCT "colour"."colour" FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id" WHERE "superhero"."skin_colour_id" IN (SELECT "id" FROM "colour" WHERE "colour" = 'Gold');

/*
Prediction Result:
('9n8',)
('siie',)
('col_761394',)
('Gold',)
('ph2',)
('ptt',)
('zjo7wgxd5ysx',)
('npi',)
('v8u',)
('yvkv42q7s',)
('9n0jxfofwsz',)
('5amsorlwyngc',)
('521gwnlas6e',)
('awg96aqb0tbi',)
('c',)
*/