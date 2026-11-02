INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO alignment (id, alignment) VALUES (2, 'Bad');
INSERT INTO alignment (id, alignment) VALUES (3, 'Neutral');
INSERT INTO alignment (id, alignment) VALUES (4, 'Villain');
INSERT INTO alignment (id, alignment) VALUES (5, 'Gray');

INSERT INTO attribute (id, attribute_name) VALUES (1, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (3, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (4, 'Durability');
INSERT INTO attribute (id, attribute_name) VALUES (5, 'Power');

INSERT INTO colour (id, colour) VALUES (1, 'White');
INSERT INTO colour (id, colour) VALUES (2, 'Amber');
INSERT INTO colour (id, colour) VALUES (3, 'Auburn');
INSERT INTO colour (id, colour) VALUES (4, 'Black');
INSERT INTO colour (id, colour) VALUES (5, 'Brown');

INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO gender (id, gender) VALUES (2, 'Female');

INSERT INTO publisher (id, publisher_name) VALUES (1, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'ABC Studios');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'Dark Comics');
INSERT INTO publisher (id, publisher_name) VALUES (4, 'DC Comics');
INSERT INTO publisher (id, publisher_name) VALUES (5, 'George Lucas');

INSERT INTO race (id, race) VALUES (1, 'Earth');
INSERT INTO race (id, race) VALUES (2, 'Alien');
INSERT INTO race (id, race) VALUES (3, 'Alpha');
INSERT INTO race (id, race) VALUES (4, 'Amazon');
INSERT INTO race (id, race) VALUES (5, 'Android');

INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, '3-D Man', 'Charles Chandler', 1, 4, 3, 2, 1, 3, 1, 188, 90);

INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'A-Bomb', 'Richard Milhouse Jones', 1, 3, 1, 1, 2, 3, 1, 203, 441);

INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Abe Sapien', 'Abraham Sapien', 1, 5, 1, 5, 3, 3, 1, 191, 65);

INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (4, 'Abin Sur', '-', 1, 5, 1, 2, 5, 4, 1, 185, 90);

INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (5, 'Abomination', 'Emil Blonsky', 1, 4, 1, 1, 2, 3, 2, 203, 441);

INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 5, 80);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 4, 75);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 3, 95);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 2, 80);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (5, 1, 85);

INSERT INTO superpower (id, power_name) VALUES (1, 'Agility');
INSERT INTO superpower (id, power_name) VALUES (2, 'Accelerated Healing');
INSERT INTO superpower (id, power_name) VALUES (3, 'Lantern Power Ring');
INSERT INTO superpower (id, power_name) VALUES (4, 'Dimensional Awareness');
INSERT INTO superpower (id, power_name) VALUES (5, 'Cold Resistance');

INSERT INTO hero_power (hero_id, power_id) VALUES (1, 5);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 4);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 3);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 2);
INSERT INTO hero_power (hero_id, power_id) VALUES (5, 1);
