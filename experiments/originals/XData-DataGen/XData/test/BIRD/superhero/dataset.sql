CREATE TABLE alignment (
    id integer NOT NULL,
    alignment varchar,
    PRIMARY KEY (id)
);
CREATE TABLE attribute (
    id integer NOT NULL,
    attribute_name varchar,
    PRIMARY KEY (id)
);
CREATE TABLE colour (
    id integer NOT NULL,
    colour varchar,
    PRIMARY KEY (id)
);
CREATE TABLE gender (
    id integer NOT NULL,
    gender varchar,
    PRIMARY KEY (id)
);
CREATE TABLE publisher (
    id integer NOT NULL,
    publisher_name varchar,
    PRIMARY KEY (id)
);
CREATE TABLE race (
    id integer NOT NULL,
    race varchar,
    PRIMARY KEY (id)
);
CREATE TABLE superpower (
    id integer NOT NULL,
    power_name varchar,
    PRIMARY KEY (id)
);
CREATE TABLE superhero (
    id integer NOT NULL,
    superhero_name varchar,
    full_name varchar,
    gender_id integer,
    eye_colour_id integer,
    hair_colour_id integer,
    skin_colour_id integer,
    race_id integer,
    publisher_id integer,
    alignment_id integer,
    height_cm integer,
    weight_kg integer,
    PRIMARY KEY (id),
    FOREIGN KEY (alignment_id) REFERENCES alignment (id),
    FOREIGN KEY (eye_colour_id) REFERENCES colour (id),
    FOREIGN KEY (gender_id) REFERENCES gender (id),
    FOREIGN KEY (hair_colour_id) REFERENCES colour (id),
    FOREIGN KEY (publisher_id) REFERENCES publisher (id),
    FOREIGN KEY (race_id) REFERENCES race (id),
    FOREIGN KEY (skin_colour_id) REFERENCES colour (id)
);
CREATE TABLE hero_attribute (
    hero_id integer,
    attribute_id integer,
    attribute_value integer,
    FOREIGN KEY (attribute_id) REFERENCES attribute (id),
    FOREIGN KEY (hero_id) REFERENCES superhero (id)
);
CREATE TABLE hero_power (
    hero_id integer,
    power_id integer,
    FOREIGN KEY (hero_id) REFERENCES superhero (id),
    FOREIGN KEY (power_id) REFERENCES superpower (id)
);