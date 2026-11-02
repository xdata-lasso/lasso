CREATE TABLE museum (
Museum_ID INTEGER,
Name VARCHAR(30),
Num_of_Staff INTEGER,
Open_Year INTEGER,
PRIMARY KEY (Museum_ID)
);
CREATE TABLE visitor (
ID INTEGER,
Name VARCHAR(30),
Level_of_membership INTEGER,
Age INTEGER,
PRIMARY KEY (ID)
);
CREATE TABLE visit (
Museum_ID INTEGER,
visitor_ID INTEGER,
Num_of_Ticket INTEGER,
Total_spent real,
time_spent time,
PRIMARY KEY (Museum_ID,visitor_ID),
FOREIGN KEY (Museum_ID) REFERENCES museum(Museum_ID),
FOREIGN KEY (visitor_ID) REFERENCES visitor(ID)
);
