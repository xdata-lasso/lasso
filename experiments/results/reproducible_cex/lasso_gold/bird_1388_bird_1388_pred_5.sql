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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('describe', 'Gregory Davis', 'bit', 'address');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('people', 'Teresa Rush', 'ten', 'newspaper');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('wear', 'Christopher Mason', 'particular', 'director');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('decision', 'Dana Hudson', 'source', 'senior');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('break', 'Melissa Armstrong', 'full', 'answer');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('outside', 'Scott Hunter', 'ask', 'career');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Republican', 'Johnny Arellano', 'ahead', 'third');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('military', 'Heather Levine', 'performance', 'hit');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('reason', 'Tracey Tucker', 'believe', 'shake');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('oil', 'Scott Miller', 'industry', 'thousand');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('control', 'Sharon Lester', 'yes', 'challenge');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('quickly', 'Jack Sandoval', 'those', 'eat');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1377, 'dark', 'Lake Coreyborough', 'language', 'Nebraska', 'New Jersey');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1378, 'father', 'Richardsonshire', 'difficult', 'Delaware', 'North Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1379, 'Congress', 'South Emily', 'my', 'Wisconsin', 'Florida');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1380, 'week', 'East Maryfurt', 'drive', 'Massachusetts', 'New York');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1385, 'happy', 'Port Patriciamouth', 'forget', 'Vermont', 'Hawaii');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1386, 'table', 'Davisstad', 'person', 'California', 'Alaska');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1387, 'site', 'Robertton', 'become', 'Maryland', 'Ohio');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1388, 'past', 'East Jimmy', 'whether', 'Michigan', 'Arizona');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1393, 'brother', 'New Elizabethshire', 'since', 'West Virginia', 'Georgia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1394, 'own', 'Tylerland', 'in', 'Kansas', 'Connecticut');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1395, 'simple', 'New David', 'sure', 'Nevada', 'Idaho');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1396, 'month', 'Markshire', 'smile', 'Indiana', 'Louisiana');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('sound', 'Angela', 'Williams', 'tristan64@example.com', 'hold', 'million', '581.712.6691x215', 1377, 'describe');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('herself', 'Angela', 'Williams', 'gloria73@example.net', 'country', 'remember', '696.813.6749', 1377, 'describe');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('sea', 'Angela', 'Williams', 'broberts@example.org', 'add', 'book', '(979)967-8427x114', 1377, 'describe');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('fight', 'Angela', 'Williams', 'jacobsonleah@example.net', 'represent', 'individual', '820.710.1702', 1377, 'describe');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('magazine', 'Edward', 'Williams', 'andrew79@example.org', 'group', 'himself', '+1-318-734-4049x6391', 1385, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('really', 'Edward', 'Williams', 'nicholas65@example.net', 'compare', 'least', '819-787-6351x484', 1385, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('treat', 'Edward', 'Williams', 'stokescraig@example.net', 'possible', 'defense', '266.449.8782', 1385, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('knowledge', 'Edward', 'Williams', 'matthewshaw@example.net', 'firm', 'model', '001-273-574-8969', 1385, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('less', 'Edward', 'Williams', 'holly15@example.net', 'thought', 'yeah', '+1-634-686-4518x37606', 1393, 'reason');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('issue', 'Edward', 'Williams', 'pwells@example.com', 'sister', 'arm', '634-332-7560', 1393, 'reason');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('environmental', 'Edward', 'Williams', 'michaelbaldwin@example.com', 'recognize', 'rock', '001-777-965-6124x81569', 1393, 'reason');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('travel', 'Edward', 'Williams', 'brewerrebecca@example.org', 'successful', 'whose', '001-300-327-2063x459', 1393, 'reason');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('claim', 'big', 1397, 'society', 'Should society dark product make energy gas.', 'sound');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('floor', 'soon', 1397, 'society', 'National weight all involve trip himself fire.', 'sound');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('pretty', 'ball', 1397, 'society', 'Kind along computer process single those.', 'sound');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('price', 'recent', 1397, 'society', 'Man care resource maintain.', 'sound');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('his', 'city', 1381, 'society', 'Improve team treat plant suffer environment.', 'magazine');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('maintain', 'skin', 1381, 'society', 'Position either over image box.', 'magazine');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('choose', 'reveal', 1381, 'society', 'Agree someone financial magazine yard.', 'magazine');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('effect', 'southern', 1381, 'society', 'Positive already city carry election sound.', 'magazine');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('coach', 'special', 1389, 'society', 'Rate society floor long same end reach step.', 'less');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('enjoy', 'then', 1389, 'society', 'Cup increase consider then war.', 'less');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('name', 'range', 1389, 'society', 'Difference way type positive phone trade wind.', 'less');
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('sell', 'case', 1389, 'society', 'Energy system anyone peace outside.', 'less');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('Edward', 'Williams', 'society')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, i.source FROM income AS i INNER JOIN member AS m ON i.link_to_member = m.member_id ORDER BY i.amount DESC, i.income_id NULLS LAST, m.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Angela', 'Williams', 'society')
*/