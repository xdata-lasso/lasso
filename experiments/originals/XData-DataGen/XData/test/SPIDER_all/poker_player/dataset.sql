CREATE TABLE people (
People_ID int,
Nationality VARCHAR(30),
Name VARCHAR(30),
Birth_Date DATE CHECK (Birth_Date > DATE '1900-01-01'),
Height real,
PRIMARY KEY (People_ID)
);

CREATE TABLE poker_player (
Poker_Player_ID int,
People_ID int,
Final_Table_Made real,
Best_Finish real,
Money_Rank real,
Earnings real,
Finish_time time,
PRIMARY KEY (Poker_Player_ID),
FOREIGN KEY (People_ID) REFERENCES people(People_ID)
);


