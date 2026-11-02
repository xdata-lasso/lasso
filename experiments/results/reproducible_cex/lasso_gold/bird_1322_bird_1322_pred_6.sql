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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Kimberly Garza', 'high', 'Meeting', 'Term herself law street class.', '52880 Burns Creek
Natashaport, IA 08093', 'point');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Brandon Hall', 'participant', 'Meeting', 'Decide environment view possible participant commercial.', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'develop');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Kristina Baldwin', 'dark', 'Meeting', 'Clear here writer policy news.', '465 Lam Mission
East Jeffreymouth, AK 77611', 'series');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('site', 'Jennifer Cole', 'sea', 'Meeting', 'Successful simply director allow firm environment.', '10310 Jones Freeway
Elizabethborough, ND 17843', 'gun');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('face', 'Sean Blake', 'available', 'Meeting', 'Tree note responsibility defense material.', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 'Democrat');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('election', 'Jay Ramirez', 'answer', 'Meeting', 'Central cause seat much section investment on.', '62473 Scott Wall Apt. 080
Port Melindaburgh, MT 64154', 'right');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('dog', 'Phillip Garcia', 'recently', 'Meeting', 'Despite young meeting before another body.', '26064 Mitchell Square Suite 234
North Beth, ND 08490', 'protect');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('chair', 'Ian Cooper', 'drive', 'Meeting', 'Civil quite others his other life edge network.', '97882 Susan Common
North Brooke, TX 31329', 'tonight');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('since', 'Andrew Stevens', 'spring', 'Meeting', 'Quite boy those.', '909 Robert Prairie
Sarahborough, TN 94373', 'everything');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('blue', 'Thomas Miller', 'figure', 'Meeting', 'Shoulder future fall citizen about.', '2475 Albert Road Apt. 183
Davidstad, FM 09517', 'mouth');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('require', 'Mark Mcclure', 'base', 'Meeting', 'Will seven medical blood personal.', '2784 Elizabeth Plaza Suite 124
North Juliaberg, KY 37431', 'middle');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('enter', 'Sarah Davis', 'land', 'themselves');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'factor', 'North Matthewberg', 'public', 'Kentucky', 'Hawaii');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://smith.com/', 'Samuel', 'Mclaughlin', 'richard48@example.org', 'either', 'start', '872-978-8957', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://tran.com/', 'Tracey', 'Gonzalez', 'robertbentley@example.net', 'choose', 'large', '(677)943-4873', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://fleming.com/', 'Darrell', 'Reynolds', 'christinaturner@example.net', 'reality', 'discuss', '443-545-5812', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://brady.com/', 'Rachel', 'Rush', 'torresjason@example.net', 'rise', 'control', '(823)216-6587x6036', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://white.biz/', 'James', 'Mccall', 'steven73@example.net', 'accept', 'summer', '001-596-670-5466x88937', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://cobb.biz/', 'Bradley', 'Hanson', 'yleon@example.net', 'walk', 'safe', '(270)365-6272x98069', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://gonzalez.com/', 'Ryan', 'Alvarado', 'donnacampbell@example.net', 'social', 'national', '+1-862-672-0465x3755', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.johnson.biz/', 'April', 'Martinez', 'clarence34@example.org', 'traditional', 'majority', '001-564-217-0805x31003', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://rasmussen.com/', 'Lindsay', 'Mccullough', 'dylanwilliams@example.com', 'speech', 'apply', '+1-323-427-1937x452', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://wilson.com/', 'Gloria', 'Hunter', 'gibsonolivia@example.net', 'value', 'onto', '619-304-9663x1931', 1001, 'enter');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.carlson.com/', 'Shelby', 'Estrada', 'jennifercruz@example.com', 'both', 'enjoy', '001-205-886-5185', 1001, 'enter');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://smith.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://tran.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://fleming.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://brady.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://white.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://cobb.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://gonzalez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.johnson.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://rasmussen.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://wilson.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.carlson.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(*) AS meeting_count FROM (SELECT e.event_id FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' GROUP BY e.event_id HAVING COUNT(a.link_to_member) > 10) AS subquery;

/*
Prediction Result:
(1,)
*/