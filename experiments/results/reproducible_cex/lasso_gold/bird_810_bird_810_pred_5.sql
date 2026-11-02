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
INSERT INTO "alignment" ("id", "alignment") VALUES (2331, 'security');
INSERT INTO "alignment" ("id", "alignment") VALUES (2332, 'down');
INSERT INTO "alignment" ("id", "alignment") VALUES (2333, 'half');
INSERT INTO "alignment" ("id", "alignment") VALUES (2334, 'yeah');
INSERT INTO "alignment" ("id", "alignment") VALUES (2379, 'energy');
INSERT INTO "alignment" ("id", "alignment") VALUES (2380, 'tree');
INSERT INTO "alignment" ("id", "alignment") VALUES (2381, 'teach');
INSERT INTO "alignment" ("id", "alignment") VALUES (2382, 'generation');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2335, 'Diane Miller');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2336, 'Tyler Hill');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2337, 'Lisa Davis');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2338, 'Leslie Carpenter');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2384, 'Zachary Owens');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2385, 'Kathleen Davis');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (2386, 'Jim Allen');
INSERT INTO "colour" ("id", "colour") VALUES (2339, 'reason');
INSERT INTO "colour" ("id", "colour") VALUES (2340, 'probably');
INSERT INTO "colour" ("id", "colour") VALUES (2341, 'service');
INSERT INTO "colour" ("id", "colour") VALUES (2342, 'week');
INSERT INTO "colour" ("id", "colour") VALUES (2387, 'past');
INSERT INTO "colour" ("id", "colour") VALUES (2388, 'head');
INSERT INTO "colour" ("id", "colour") VALUES (2389, 'anything');
INSERT INTO "colour" ("id", "colour") VALUES (2390, 'apply');
INSERT INTO "colour" ("id", "colour") VALUES (2359, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2363, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2407, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2411, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (2343, 'green');
INSERT INTO "gender" ("id", "gender") VALUES (2344, 'thousand');
INSERT INTO "gender" ("id", "gender") VALUES (2345, 'window');
INSERT INTO "gender" ("id", "gender") VALUES (2346, 'organization');
INSERT INTO "gender" ("id", "gender") VALUES (2391, 'father');
INSERT INTO "gender" ("id", "gender") VALUES (2392, 'miss');
INSERT INTO "gender" ("id", "gender") VALUES (2393, 'picture');
INSERT INTO "gender" ("id", "gender") VALUES (2394, 'us');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2347, 'Scott Miller');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2348, 'Patricia Baker');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2349, 'Kenneth Montgomery');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2350, 'Stephen Gardner');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2395, 'Megan Mitchell');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2396, 'Brian Anderson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2397, 'Jacob Powell');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2398, 'Anthony Hoffman');
INSERT INTO "race" ("id", "race") VALUES (2351, 'quality');
INSERT INTO "race" ("id", "race") VALUES (2353, 'five');
INSERT INTO "race" ("id", "race") VALUES (2354, 'meeting');
INSERT INTO "race" ("id", "race") VALUES (2399, 'election');
INSERT INTO "race" ("id", "race") VALUES (2352, 'on');
INSERT INTO "race" ("id", "race") VALUES (2400, 'fight');
INSERT INTO "race" ("id", "race") VALUES (2401, 'back');
INSERT INTO "race" ("id", "race") VALUES (2402, 'mother');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2356, 'Joshua Bryan', 'Bianca Wood', 2343, 2339, 2359, 2363, 2351, 2347, 2331, 2367, 2371);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2357, 'Anthony Gonzales', 'Emma Owens', 2343, 2339, 2359, 2363, 2351, 2347, 2331, 2390.0, 2396.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2358, 'Mr. Lawrence Edwards', 'David Davis', 2343, 2339, 2359, 2363, 2351, 2347, 2331, 2413.0, 2421.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2403, 'Morgan Valencia', 'James Gilbert', 2343, 2339, 2359, 2363, 2351, 2347, 2331, 2436.0, 2446.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2355, 'Melinda Evans', 'Jennifer Williams', 2391, 2387, 2407, 2411, 2352, 2395, 2379, 2368, 2372);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2404, 'Lisa Anderson', 'Micheal Brock', 2391, 2387, 2407, 2411, 2352, 2395, 2379, 2438.0, 2444.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2405, 'Jake Hatfield', 'Brittany Barry', 2391, 2387, 2407, 2411, 2352, 2395, 2379, 2461.0, 2469.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2406, 'Holly Thomas', 'Timothy Flores', 2391, 2387, 2407, 2411, 2352, 2395, 2379, 2484.0, 2494.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2356, 2335, 2444.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2356, 2335, 2382.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2356, 2335, 2389.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2356, 2335, 2396.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2355, 2336, 2444.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2355, 2336, 2430.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2355, 2336, 2437.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2355, 2336, 2375);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN race AS T3 ON T1.race_id = T3.id ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('on',)
*/

-- Prediction Query
SELECT T1.race FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id INNER JOIN hero_attribute AS T3 ON T2.id = T3.hero_id ORDER BY T3.attribute_value DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('quality',)
*/