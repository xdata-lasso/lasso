CREATE TABLE conductor (
Conductor_ID INTEGER,
Name VARCHAR(30),
Age INTEGER,
Nationality VARCHAR(30),
Year_of_Work INTEGER,
PRIMARY KEY (Conductor_ID)
);

CREATE TABLE orchestra (
Orchestra_ID INTEGER,
OrchestraName VARCHAR(30),
Conductor_ID INTEGER,
Record_Company VARCHAR(30),
Year_of_Founded INTEGER,
Major_Record_Format VARCHAR(30),
PRIMARY KEY (Orchestra_ID),
FOREIGN KEY (Conductor_ID) REFERENCES conductor(Conductor_ID)
);

CREATE TABLE performance (
Performance_ID INTEGER,
Orchestra_ID INTEGER,
Type VARCHAR(30),
Date VARCHAR(30),
Official_ratings_mil real,
Weekly_rank VARCHAR(30),
Share VARCHAR(30),
PRIMARY KEY (Performance_ID),
FOREIGN KEY (Orchestra_ID) REFERENCES orchestra(Orchestra_ID)
);

CREATE TABLE show (
Show_ID INTEGER,
Performance_ID INTEGER,
Result VARCHAR(30),
If_first_show bool,
Attendance real,
FOREIGN KEY (Performance_ID) REFERENCES performance(Performance_ID)
);
