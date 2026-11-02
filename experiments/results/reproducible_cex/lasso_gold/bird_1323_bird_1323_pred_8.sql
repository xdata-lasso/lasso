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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Lance Hoffman', 'money', 'certainly', 'Quite boy those.', '91361 Beth Canyon
South Dianeshire, NC 41968', 'young');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Meredith Barnes', 'individual', 'Mr', 'Shoulder future fall citizen about.', 'USNS Santiago
FPO AA 31786', 'safe');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Donald Booth', 'usually', 'minute', 'Will seven medical blood personal.', '475 Albert Road
North Amandahaven, KS 17862', 'again');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('site', 'Caitlin Henderson', 'who', 'benefit', 'Participant check several much single morning a.', 'USS Suarez
FPO AA 37854', 'tough');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('face', 'Daniel Gallagher', 'question', 'someone', 'Major born guy world southern dream.', '808 Huynh Cove Apt. 411
West Juan, IL 94559', 'up');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('election', 'James Howard', 'low', 'anyone', 'There water beat magazine attorney.', '740 Cynthia Village Suite 005
Lake Tina, GA 97655', 'southern');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('dog', 'Dennis Williams', 'character', 'traditional', 'She campaign little near enter their institution.', '011 Amy Village Suite 982
Andersonport, MN 05730', 'parent');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('chair', 'Calvin Nielsen', 'evidence', 'break', 'Up sense ready require human.', 'PSC 3315, Box 8692
APO AE 21800', 'husband');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('since', 'Edward Fuller', 'employee', 'claim', 'Just military building different full open.', 'Unit 2602 Box 5634
DPO AE 92418', 'me');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('blue', 'Heidi Lee', 'size', 'product', 'Open according remain arrive attack.', '3375 Hoover Well
East Andrew, ID 52728', 'according');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('require', 'Matthew Mejia', 'option', 'collection', 'Teacher audience draw.', '5868 Crosby Crescent
Gregoryview, AZ 14709', 'yes');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('sit', 'Dr. Sharon James', 'nothing', 'structure', 'Democrat car very number line six space.', '569 Paul Ports Apt. 406
New Saraside, TX 94798', 'he');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('wait', 'Roy Martin', 'everyone', 'response', 'Behind probably great in tell.', 'USNS Diaz
FPO AE 87563', 'fire');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('offer', 'Michael Miles', 'skin', 'pick', 'Pull worker better.', 'PSC 9514, Box 8465
APO AA 91885', 'some');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('begin', 'Andrea Reid', 'pattern', 'attack', 'Rock song body court movie cell.', '66299 Sullivan Village
West Justinchester, WY 76520', 'in');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('performance', 'Danielle Ford', 'later', 'image', 'Everything economic type kitchen.', '7738 Leon Underpass Apt. 148
Clarencebury, TX 41188', 'tonight');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('knowledge', 'Timothy Watts', 'water', 'I', 'Better present music address behavior send door.', '00379 Stanley Roads
Lake Heather, NM 52884', 'thing');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('almost', 'Frederick Tate', 'past', 'management', 'Magazine degree husband around her world.', '63287 Angela Vista
South Dennismouth, TN 70117', 'kind');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('all', 'Rodney Trujillo', 'inside', 'newspaper', 'Unit size expect recent room.', 'Unit 9579 Box 8687
DPO AE 97973', 'small');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('better', 'Austin Gentry', 'high', 'enter', 'Product main couple design around save article.', '3487 Joshua Club Suite 345
Patricialand, DC 20270', 'simple');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('discover', 'Michelle Lewis', 'discuss', 'on', 'Arm once me system church whether.', '316 Rivera Mountain
Brownchester, MS 77057', 'office');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('such', 'Connie Robinson', 'least', 'mention');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'air', 'Rogersfurt', 'shake', 'Hawaii', 'New Jersey');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.vargas-alvarado.com/', 'Alyssa', 'Smith', 'hernandezlisa@example.com', 'prove', 'oil', '259.577.0348x24771', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.white-green.com/', 'Ronald', 'Ferguson', 'mcknightdavid@example.com', 'teach', 'although', '001-424-980-8613x171', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://rogers-hobbs.com/', 'Julie', 'Hill', 'kimberlyjames@example.com', 'million', 'look', '001-548-446-7737x826', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://ruiz.net/', 'Mark', 'Mccann', 'michelle64@example.net', 'many', 'behavior', '946-458-4044', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://santos.com/', 'Jacqueline', 'Tran', 'lynchjody@example.org', 'happen', 'forward', '887.555.8867x533', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.combs.com/', 'Joseph', 'Terry', 'josephmiller@example.org', 'issue', 'entire', '001-360-957-6627x02895', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.caldwell-elliott.com/', 'John', 'Martinez', 'andreamoore@example.com', 'goal', 'game', '687-702-6217', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://jackson-lawson.com/', 'David', 'Oneill', 'enorris@example.com', 'full', 'business', '+1-561-658-6578x091', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://lane.org/', 'James', 'Henry', 'halljasmine@example.net', 'religious', 'spring', '216.711.7240', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://gonzalez.com/', 'Amanda', 'Salas', 'ojones@example.com', 'book', 'international', '4454562386', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://burke.com/', 'Kathleen', 'Andrews', 'ronaldstephens@example.net', 'toward', 'treatment', '(519)969-3792', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://wood.biz/', 'Jacob', 'Harrison', 'rebekahserrano@example.org', 'college', 'my', '+1-647-840-7482x1759', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.yu-reid.info/', 'Javier', 'Alexander', 'martinkyle@example.net', 'girl', 'thank', '001-647-643-6713x695', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://gross.com/', 'Todd', 'Lopez', 'scott74@example.net', 'its', 'ability', '5647090974', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://petersen-vargas.com/', 'Jenny', 'Williams', 'gbender@example.net', 'rule', 'really', '239.742.1047', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.keith-sanchez.info/', 'Tiffany', 'Everett', 'mkim@example.org', 'mission', 'true', '001-621-445-6232x8588', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://snyder.com/', 'Alicia', 'Woods', 'mnavarro@example.com', 'fight', 'occur', '374-851-7123x685', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.salinas-peterson.org/', 'Justin', 'Short', 'davissuzanne@example.net', 'recognize', 'maintain', '7483175496', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.vaughan.info/', 'Craig', 'Morales', 'keyemily@example.com', 'you', 'job', '+1-437-209-8593x17461', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://joseph.com/', 'Jeremy', 'Jones', 'hinesgregory@example.net', 'institution', 'arm', '9477113826', 1001, 'such');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://sanchez.net/', 'Harry', 'Soto', 'lmoon@example.net', 'soon', 'cup', '+1-986-992-6179x64053', 1001, 'such');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://www.vargas-alvarado.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.white-green.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://rogers-hobbs.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://ruiz.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://santos.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://www.combs.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://www.caldwell-elliott.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://jackson-lawson.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://lane.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://gonzalez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://burke.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://wood.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.yu-reid.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://gross.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://petersen-vargas.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://www.keith-sanchez.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://snyder.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.salinas-peterson.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.vaughan.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://joseph.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://sanchez.net/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Lance Hoffman',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN budget AS T3 ON T1.event_id = T3.link_to_event WHERE T3.category <> 'Fundraising' GROUP BY T1.event_id HAVING COUNT(T2.link_to_member) > 20;

/*
Prediction Result:
*/