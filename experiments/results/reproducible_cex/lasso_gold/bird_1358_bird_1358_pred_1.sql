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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('suddenly', 'Terri Marquez', 'pattern', 'recognize');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('across', 'Desiree Woodard', 'blue', 'threat');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('door', 'Judy Robinson', 'account', 'those');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('entire', 'Joseph Hanson', 'much', 'house');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('yourself', 'Darryl Acosta', 'nor', 'box');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('what', 'Nicholas Lawrence', 'price', 'ready');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('why', 'Jacob Santos', 'anything', 'think');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('task', 'Shawn Scott', 'recently', 'again');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1181, 'option', 'Kennethville', 'southern', 'Rhode Island', 'Utah');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1182, 'radio', 'Brownview', 'effect', 'Montana', 'Florida');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1183, 'phone', 'Michelleview', 'we', 'Texas', 'Washington');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1184, 'politics', 'Jacobhaven', 'art', 'Massachusetts', 'Alaska');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1189, 'road', 'Martinezview', 'kid', 'North Carolina', 'Connecticut');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1190, 'business', 'Milesborough', 'then', 'South Carolina', 'New York');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1191, 'keep', 'West Robertville', 'way', 'Delaware', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1192, 'life', 'Cindyberg', 'book', 'Maine', 'Wyoming');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('reality', 'Rebecca', 'Lozano', 'qknox@example.com', 'majority', 'size', '655-361-1002x2557', 1181, 'suddenly');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('modern', 'Richard', 'Cabrera', 'megan82@example.com', 'doctor', 'try', '+1-768-446-0223x56972', 1181, 'suddenly');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('find', 'Jillian', 'Cooper', 'ruizjoyce@example.net', 'hear', 'food', '001-917-352-5007x43292', 1181, 'suddenly');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('event', 'Brandy', 'Reeves', 'staceylam@example.net', 'dog', 'kitchen', '(296)566-6760', 1181, 'suddenly');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('everyone', 'Michael', 'Cooley', 'powersrebecca@example.net', 'behind', 'contain', '554-394-7170x99917', 1189, 'yourself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('theory', 'Robert', 'Watts', 'fhernandez@example.net', 'apply', 'two', '(352)416-6746x762', 1189, 'yourself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('necessary', 'Ethan', 'Castillo', 'cummingscraig@example.com', 'black', 'among', '001-702-216-9797x296', 1189, 'yourself');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('defense', 'Amy', 'Young', 'stephenmadden@example.com', 'tax', 'together', '+1-527-771-6701x45089', 1189, 'yourself');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('side', 'four', 1193, 'Dues', 'Generation put his stuff next write approach.', 'reality');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('hour', 'likely', 1192.0, 'Dues', 'Can himself open cold statement.', 'reality');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('address', 'likely', 1199.0, 'Dues', 'Way lay minute model its.', 'reality');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('wait', 'likely', 1206.0, 'Dues', 'Garden top grow could.', 'reality');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('natural', 'four', 1185, 'Dues', 'Adult above safe difficult theory.', 'everyone');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('rise', 'likely', 1200.0, 'Dues', 'Measure light many close.', 'everyone');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('school', 'likely', 1207.0, 'Dues', 'Fly former everything medical nearly her stage.', 'everyone');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('present', 'likely', 1214.0, 'Dues', 'Learn soon large task.', 'everyone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.source = 'Dues' ORDER BY T2.date_received, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Michael', 'Cooley')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM income AS i INNER JOIN member AS m ON i.link_to_member = m.member_id WHERE i.source = 'Dues' AND i.date_received = (SELECT MIN(date_received) FROM income WHERE source = 'Dues') LIMIT 1;

/*
Prediction Result:
('Rebecca', 'Lozano')
*/