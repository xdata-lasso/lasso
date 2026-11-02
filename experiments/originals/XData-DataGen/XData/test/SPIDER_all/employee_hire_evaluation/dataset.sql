CREATE TABLE employee (
Employee_ID INTEGER,
Name VARCHAR(30),
Age INTEGER,
City VARCHAR(30),
PRIMARY KEY (Employee_ID)
);
CREATE TABLE shop (
Shop_ID INTEGER,
Name VARCHAR(30),
Location VARCHAR(30),
District VARCHAR(30),
Number_products INTEGER,
Manager_name VARCHAR(30),
PRIMARY KEY (Shop_ID)
);
CREATE TABLE hiring (
Shop_ID INTEGER,
Employee_ID INTEGER,
Start_from VARCHAR(30),
Is_full_time bool,
PRIMARY KEY (Employee_ID),
FOREIGN KEY (Shop_ID) REFERENCES shop(Shop_ID),
FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID)
);
CREATE TABLE evaluation (
Employee_ID INTEGER,
Year_awarded VARCHAR(30),
Bonus real,
PRIMARY KEY (Employee_ID,Year_awarded),
FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID)
);
