-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('herself', 'Jill Juarez', 'still', 'actually');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('both', 'Brandon Jordan', 'garden', 'actually');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('benefit', 'Kayla Garcia', 'treat', 'actually');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('accept', 'Julian Carlson', 'image', 'actually');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('really', 'Amanda Terrell', 'partner', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('red', 'Jennifer Goodwin', 'rise', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('hear', 'Jessica Smith', 'parent', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('compare', 'Jorge Stone', 'do', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('cultural', 'Maria Cooke', 'teacher', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('message', 'Katherine Taylor', 'if', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('prove', 'Jerry Brown', 'or', 'side');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('note', 'Adam Taylor', 'mouth', 'side');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1093, 'film', 'Hughesland', 'share', 'Oklahoma', 'Kansas');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1097, 'house', 'Fordshire', 'rock', 'North Carolina', 'Georgia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1101, 'miss', 'Cohenchester', 'see', 'New Hampshire', 'New York');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('owner', 'Oscar', 'Brown', 'wardsheryl@example.net', 'good', 'trade', '759-837-5265x4793', 1093, 'herself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('near', 'Dominic', 'Hamilton', 'mwheeler@example.com', 'law', 'rather', '565-919-3982x807', 1093, 'herself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('condition', 'Kevin', 'Fisher', 'tayloradam@example.com', 'team', 'phone', '916-872-4342x6617', 1093, 'herself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('reveal', 'Trevor', 'Washington', 'meagan65@example.com', 'than', 'century', '+1-386-580-5891', 1093, 'herself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('hair', 'Kenneth', 'Cross', 'gbailey@example.com', 'contain', 'opportunity', '(522)566-0937x9660', 1097, 'really');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('ago', 'Samantha', 'Bailey', 'tflores@example.org', 'old', 'last', '919-718-2553x714', 1097, 'really');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('meeting', 'Christopher', 'Cooper', 'johnsonmatthew@example.org', 'collection', 'maintain', '+1-369-469-1557x924', 1097, 'really');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('book', 'Marie', 'Mueller', 'sarahyang@example.net', 'give', 'each', '813-841-2528x66929', 1097, 'really');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('computer', 'Laura', 'Norman', 'armstrongjoseph@example.net', 'everyone', 'begin', '001-733-695-9629x23309', 1101, 'cultural');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('beautiful', 'Jeffrey', 'Cunningham', 'amber07@example.net', 'happen', 'leg', '+1-282-654-4948x126', 1101, 'cultural');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('other', 'Antonio', 'Barton', 'veronicagarcia@example.net', 'training', 'tree', '+1-822-932-5367x2946', 1101, 'cultural');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('allow', 'Keith', 'Simpson', 'kennethkidd@example.com', 'technology', 'buy', '216-384-5775', 1101, 'cultural');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id GROUP BY T2.major_id ORDER BY COUNT(T2.college) DESC, T2.college NULLS LAST LIMIT 1;

/*
Gold Result:
('actually',)
*/

-- Prediction Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id GROUP BY T2.college ORDER BY COUNT(T2.college) DESC, T2.college NULLS LAST LIMIT 1;

/*
Prediction Result:
('side',)
*/