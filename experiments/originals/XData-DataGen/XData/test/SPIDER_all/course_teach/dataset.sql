CREATE TABLE course (
Course_ID int,
Staring_Date VARCHAR(30),
Course VARCHAR(30),
PRIMARY KEY (Course_ID)
);

CREATE TABLE teacher (
Teacher_ID INTEGER,
Name VARCHAR(30),
Age INTEGER,
Hometown VARCHAR(30),
PRIMARY KEY (Teacher_ID)
);

CREATE TABLE course_arrange (
Course_ID INTEGER,
Teacher_ID INTEGER,
Grade INTEGER,
PRIMARY KEY (Course_ID,Teacher_ID,Grade),
FOREIGN KEY (Course_ID) REFERENCES course(Course_ID),
FOREIGN KEY (Teacher_ID) REFERENCES teacher(Teacher_ID)
);