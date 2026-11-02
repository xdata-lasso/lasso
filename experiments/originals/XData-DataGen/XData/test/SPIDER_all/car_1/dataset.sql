CREATE TABLE continents ( 
	ContId INTEGER PRIMARY KEY, 
	Continent VARCHAR(30) 
);

CREATE TABLE countries (
	CountryId INTEGER PRIMARY KEY, 
	CountryName VARCHAR(30), 
	Continent INTEGER,
	FOREIGN KEY (Continent) REFERENCES continents(ContId)
);


CREATE TABLE car_makers ( 
	Id INTEGER PRIMARY KEY, 
	Maker VARCHAR(30), 
	FullName VARCHAR(30), 
	Country VARCHAR(30),
	FOREIGN KEY (Country) REFERENCES countries(CountryId)
);


CREATE TABLE model_list ( 
	ModelId INTEGER PRIMARY KEY, 
	Maker INTEGER, 
	Model VARCHAR(30) UNIQUE,
	FOREIGN KEY (Maker) REFERENCES car_makers (Id)

);

CREATE TABLE car_names ( 
	MakeId INTEGER PRIMARY KEY, 
	Model VARCHAR(30), 
	Make VARCHAR(30),
	FOREIGN KEY (Model) REFERENCES model_list (Model)
);

CREATE TABLE cars_data (
	Id INTEGER PRIMARY KEY, 
	MPG VARCHAR(30), 
	Cylinders INTEGER, 
	Edispl REAL, 
	Horsepower VARCHAR(30), 
	Weight INTEGER, 
	Accelerate REAL, 
	Year INTEGER,
	FOREIGN KEY (Id) REFERENCES car_names (MakeId)
);

