CREATE TABLE battle (
id INTEGER,
name VARCHAR(30),
date VARCHAR(30),
bulgarian_commander VARCHAR(30),
latin_commander VARCHAR(30),
result VARCHAR(30),
PRIMARY KEY(id)
);

CREATE TABLE ship (
lost_in_battle INTEGER,
id INTEGER,
name VARCHAR(30),
tonnage VARCHAR(30),
ship_type VARCHAR(30),
location VARCHAR(30),
disposition_of_ship VARCHAR(30),
PRIMARY KEY(id),
FOREIGN KEY(lost_in_battle) REFERENCES battle(id) 
);


CREATE TABLE death (
caused_by_ship_id INTEGER,
id INTEGER,
note VARCHAR(30),
killed INTEGER,
injured INTEGER,
PRIMARY KEY(id),
FOREIGN KEY (caused_by_ship_id) REFERENCES ship(id) 
);

