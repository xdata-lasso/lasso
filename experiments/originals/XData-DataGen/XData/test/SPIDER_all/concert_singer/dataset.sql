CREATE TABLE stadium (
Stadium_ID INTEGER,
Location VARCHAR(30),
Name VARCHAR(30),
Capacity INTEGER,
Highest INTEGER,
Lowest INTEGER,
Average INTEGER,
PRIMARY KEY (Stadium_ID)
);

CREATE TABLE singer (
Singer_ID INTEGER,
Name VARCHAR(30),
Country VARCHAR(30),
Song_Name VARCHAR(30),
Song_release_year VARCHAR(30),
Age INTEGER,
Is_male bool,
PRIMARY KEY (Singer_ID)
);

CREATE TABLE concert (
concert_ID INTEGER,
concert_Name VARCHAR(30),
Theme VARCHAR(30),
Stadium_ID INTEGER,
Year VARCHAR(30),
PRIMARY KEY (concert_ID),
FOREIGN KEY (Stadium_ID) REFERENCES stadium(Stadium_ID)
);

CREATE TABLE singer_in_concert (
concert_ID INTEGER,
Singer_ID INTEGER,
PRIMARY KEY (concert_ID,Singer_ID),
FOREIGN KEY (concert_ID) REFERENCES concert(concert_ID),
FOREIGN KEY (Singer_ID) REFERENCES singer(Singer_ID)
);