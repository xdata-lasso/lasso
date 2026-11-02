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
INSERT INTO "alignment" ("id", "alignment") VALUES (2267, 'do');
INSERT INTO "alignment" ("id", "alignment") VALUES (2268, 'possible');
INSERT INTO "alignment" ("id", "alignment") VALUES (2269, 'short');
INSERT INTO "alignment" ("id", "alignment") VALUES (2270, 'step');
INSERT INTO "alignment" ("id", "alignment") VALUES (2307, 'job');
INSERT INTO "alignment" ("id", "alignment") VALUES (2308, 'group');
INSERT INTO "alignment" ("id", "alignment") VALUES (2309, 'their');
INSERT INTO "alignment" ("id", "alignment") VALUES (2310, 'inside');
INSERT INTO "colour" ("id", "colour") VALUES (2271, 'when');
INSERT INTO "colour" ("id", "colour") VALUES (2272, 'trial');
INSERT INTO "colour" ("id", "colour") VALUES (2273, 'reason');
INSERT INTO "colour" ("id", "colour") VALUES (2274, 'near');
INSERT INTO "colour" ("id", "colour") VALUES (2311, 'just');
INSERT INTO "colour" ("id", "colour") VALUES (2312, 'show');
INSERT INTO "colour" ("id", "colour") VALUES (2313, 'beyond');
INSERT INTO "colour" ("id", "colour") VALUES (2314, 'form');
INSERT INTO "colour" ("id", "colour") VALUES (2291, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2295, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2331, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2335, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (2275, 'fish');
INSERT INTO "gender" ("id", "gender") VALUES (2276, 'low');
INSERT INTO "gender" ("id", "gender") VALUES (2277, 'question');
INSERT INTO "gender" ("id", "gender") VALUES (2278, 'allow');
INSERT INTO "gender" ("id", "gender") VALUES (2315, 'late');
INSERT INTO "gender" ("id", "gender") VALUES (2316, 'reduce');
INSERT INTO "gender" ("id", "gender") VALUES (2317, 'house');
INSERT INTO "gender" ("id", "gender") VALUES (2318, 'claim');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2279, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2281, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2282, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2319, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2280, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2320, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2321, 'DC Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2322, 'DC Comics');
INSERT INTO "race" ("id", "race") VALUES (2283, 'ask');
INSERT INTO "race" ("id", "race") VALUES (2284, 'measure');
INSERT INTO "race" ("id", "race") VALUES (2285, 'throw');
INSERT INTO "race" ("id", "race") VALUES (2286, 'interest');
INSERT INTO "race" ("id", "race") VALUES (2323, 'right');
INSERT INTO "race" ("id", "race") VALUES (2324, 'wind');
INSERT INTO "race" ("id", "race") VALUES (2325, 'matter');
INSERT INTO "race" ("id", "race") VALUES (2326, 'audience');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2288, 'Bradley Reynolds', 'Elizabeth Wagner', 2275, 2271, 2291, 2295, 2283, 2279, 2267, 2299, 2418.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2289, 'Steven Morris', 'Ricky Wilson', 2275, 2271, 2291, 2295, 2283, 2279, 2267, 2322.0, 2328.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2290, 'Cameron Weber', 'Sherry Arnold', 2275, 2271, 2291, 2295, 2283, 2279, 2267, 2345.0, 2353.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2327, 'Michelle James', 'Jessica Beasley', 2275, 2271, 2291, 2295, 2283, 2279, 2267, 2368.0, 2378.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2287, 'Brian Joseph', 'Jenny Moon', 2315, 2311, 2331, 2335, 2323, 2280, 2307, 2300, 2418.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2328, 'Jacqueline Anderson', 'Dwayne Edwards', 2315, 2311, 2331, 2335, 2323, 2280, 2307, 2362.0, 2368.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2329, 'Tyler Hoffman', 'Jordan Moore', 2315, 2311, 2331, 2335, 2323, 2280, 2307, 2385.0, 2393.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2330, 'Jennifer Russo', 'Dr. Gregory Hawkins', 2315, 2311, 2331, 2335, 2323, 2280, 2307, 2408.0, 2303);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'DC Comics' ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Brian Joseph',)
*/

-- Prediction Query
SELECT T2.superhero_name FROM publisher AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.publisher_id WHERE T1.publisher_name = 'DC Comics' AND NOT T2.weight_kg IS NULL ORDER BY T2.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bradley Reynolds',)
*/