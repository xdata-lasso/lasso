-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentLastA', 'StudentFirstA', 4, 110);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentLastB', 'StudentFirstB', 5, 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Zimmerman', 'Charlie', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Anderson', 'victor', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Miller', 'Alice', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Bob', 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Davis', 'Diana', 111);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Evans', 'Edward', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM teachers WHERE (classroom = 110) ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
('victor',)
*/

-- Prediction Query
SELECT firstname FROM teachers WHERE classroom = 110;

/*
Prediction Result:
('Charlie',)
('victor',)
('Alice',)
*/