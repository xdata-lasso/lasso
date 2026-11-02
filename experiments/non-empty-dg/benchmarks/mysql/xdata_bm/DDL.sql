SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE classroom (building VARCHAR(15), room_number VARCHAR(7), capacity DECIMAL(4, 0), PRIMARY KEY (building, room_number));

CREATE TABLE department (dept_name VARCHAR(20), building VARCHAR(15), budget DECIMAL(12, 2) CHECK (budget > 0), PRIMARY KEY (dept_name));

CREATE TABLE course (course_id VARCHAR(8), title VARCHAR(50), dept_name VARCHAR(20), credits DECIMAL(2, 0) CHECK (credits > 0), PRIMARY KEY (course_id), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE instructor (ID VARCHAR(5), name VARCHAR(20) NOT NULL, dept_name VARCHAR(20), salary DECIMAL(8, 2) CHECK (salary > 29000), PRIMARY KEY (ID), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE section (course_id VARCHAR(8), sec_id VARCHAR(8), semester VARCHAR(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), year DECIMAL(4, 0) CHECK (year > 1701 AND year < 2100), building VARCHAR(15), room_number VARCHAR(7), time_slot_id VARCHAR(4), PRIMARY KEY (course_id, sec_id, semester, year), FOREIGN KEY (course_id) REFERENCES course (course_id) ON delete CASCADE, FOREIGN KEY (building, room_number) REFERENCES classroom (building, room_number) ON delete SET NULL);

CREATE TABLE teaches (ID VARCHAR(5), course_id VARCHAR(8), sec_id VARCHAR(8), semester VARCHAR(6), year DECIMAL(4, 0), PRIMARY KEY (ID, course_id, sec_id, semester, year), FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON delete CASCADE, FOREIGN KEY (ID) REFERENCES instructor (ID) ON delete CASCADE);

CREATE TABLE student (ID VARCHAR(5), name VARCHAR(20) NOT NULL, dept_name VARCHAR(20), tot_cred DECIMAL(3, 0) CHECK (tot_cred >= 0), PRIMARY KEY (ID), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE takes (ID VARCHAR(5), course_id VARCHAR(8), sec_id VARCHAR(8), semester VARCHAR(6), year DECIMAL(4, 0), grade VARCHAR(2), PRIMARY KEY (ID, course_id, sec_id, semester, year), FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON delete CASCADE, FOREIGN KEY (ID) REFERENCES student (ID) ON delete CASCADE);

CREATE TABLE advisor (s_ID VARCHAR(5), i_ID VARCHAR(5), PRIMARY KEY (s_ID), FOREIGN KEY (i_ID) REFERENCES instructor (ID) ON delete SET NULL, FOREIGN KEY (s_ID) REFERENCES student (ID) ON delete CASCADE);

CREATE TABLE time_slot (time_slot_id VARCHAR(4), day VARCHAR(1), start_hr DECIMAL(2) CHECK (start_hr >= 0 AND start_hr < 24), start_min DECIMAL(2) CHECK (start_min >= 0 AND start_min < 60), end_hr DECIMAL(2) CHECK (end_hr >= 0 AND end_hr < 24), end_min DECIMAL(2) CHECK (end_min >= 0 AND end_min < 60), PRIMARY KEY (time_slot_id, day, start_hr, start_min));

CREATE TABLE prereq (course_id VARCHAR(8), prereq_id VARCHAR(8), PRIMARY KEY (course_id, prereq_id), FOREIGN KEY (course_id) REFERENCES course (course_id) ON delete CASCADE, FOREIGN KEY (prereq_id) REFERENCES course (course_id));

CREATE TABLE grade_value (grade VARCHAR(2), value DECIMAL(4, 2), PRIMARY KEY (grade));
