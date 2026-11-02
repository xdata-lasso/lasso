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
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__994a5c', 't3__e445d6', 't3__74e9fc', '7zwau2dwyr', '13pyu', '8d99rljsl', 't3__396aec', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__1f0a77', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'a7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't3__e445d6', 't3__74e9fc', '62', '0v', 'q8qdjpe1', 't3__396aec', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '1', 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'q51oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't3__e445d6', 't3__74e9fc', 'b5', 'f41', '80terbfokvee', 't3__396aec', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't3__e445d6', 't3__74e9fc', 'jdlhlzpdyxk0', '0', 'q', 't3__396aec', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__2b9a42', 'io', '8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', 'f0y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__ead899', 'pmpjjvec', 'trn6j72v', 'kwegrf6snl45', 'jw5pbgwojn', 'hh6va3tdx5hn', '5b733o58z', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'um5', 'zbuo4nrq', 'rofqyp5s5b');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__28187a', 'unw6klfa', 587.783596, 558.971814, 1419861592, '4ecigce376n', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'hncprjtu0dz', 521.610309, 654.674676, -1748371085, 'q8', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', '6ah', 418.948509, 532.326819, -932772113, 'lq7xb7', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__d94bbc', 'vacx7afu5', 354.593207, 432.405958, 76996700, 'o72ctdc', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', '3dohvu0', 507.185482, 397.847489, -154207334, 'rmkio18ri2', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'z0kaq', 309.39382, 957.304199, 1388796595, 'g', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'p', 543.088934, 249.739912, -1452518801, 'tsr54o', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__d8e8d1', 'ur8kzi0', 103.934031, 577.020002, -1531116262, '7fznqcuex', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'ph2', 'nd', 893.16532, 'wnqcx', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'n2f3dqv0gcb9', 'ozk3zbily', 279.382219, 'n6v', 't1__994a5c', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'sj3ayxp1q430', 'jh3den8', 596.764785, '6', 'C', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '8507cvtjp', 'ttg6bnou5zi3', 510.534763, '4', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '5lnpim5k58qs', '7p2r94gt', 796.553419, '2mnajjla3o', '@', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'v8u', 'tmu2n', 76.823924, '78lfvyz7zz', '@', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '7sx58', 'b4pmaus3auv', 202.422113, 'rpdjwzw5ch', 't1__1f0a77', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '9mo7', '5a9n0jx', 81.754381, 'ws', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'do2zobb', 'q0k32od', 357.061424, '5am', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'lboeowii1z5', 'xih6', 946.669761, 'q2xlyoto', 'A', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '9oaawg', '6aqb0tbin', 58.176945, '9tajz9td', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'n5wcgumbc', '3tdu6bd0w960', 460.649748, 'vzxw1rxe9yf', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'y0', '8ftp6ewtqx', 361.5356, 'jaby', 't1__1f0a77', 'Q');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'mzn2mfx7h3', 'p6sto1cj', 835.790392, 'h5knz', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'ys7dyyd1jmg', 'jach8qta8y3', 5.194667, 'v4ygmayq3', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'dqrhm', 'wlic7dn2', 828.220682, 'p490xdmsqt', 'A', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'el', 'u', 598.265359, '9', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'i9f2ccukjq1q', 'ik1yhb', 414.619293, 'ls', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'tvb6m4iz78', 'q', 857.91055, 'lud8f', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'tb8r9114qbre', '6bjeuuwsj8k', 154.006653, '5wpxlvris', 't1__994a5c', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'c8s3b7v88k', 'dmdbdh', 303.260196, 'j47nxar50h', 'A', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'punmwfwxqrl', 'w', 164.859551, '14r5dqtsmg97', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'aqz2o20pj6d', 'dlysu6iphd', 168.487055, '2gir31', '@', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'mb3aj0ju0', '3r', 907.509317, '33ir1ax', '?', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'qjektb1d2', 'zg3r', 568.592974, 'wns', 't1__1f0a77', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', '47j2ja8dccy3', 'vjwq49yrnx', 294.236852, '6dvdxdo2v7', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', '3gvpl', '9fj', 333.3832, 'un7k10', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', '1rgeza', 'xc1clupgly', 526.310762, 'oitxeilpe', 'A', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', '19cy7od', '033dlhdsvnh', 73.385641, '9lqv26u3', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', '1spxpw30', 'g', 358.454959, 'xginlj6idm', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', '62ocagj', 'ev', 364.303078, 'lu49ku', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_32', 'o', '8c', 47.421322, 'uekhllbw', 't1__994a5c', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_33', 'dpu5v0', 'du', 594.359145, '9v2z129', 'A', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_34', 'db2f0c', '96xiyet8', 774.266879, 'hcf', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_35', '6cfperxa', '1sjv8nv3d', 59.584068, 'kuez', '@', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_36', 'ctehia3cmvb', '7vpc0xffwo', 271.763231, 'sk', '?', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_37', 'ui', '7f8', 157.444431, 'hiu5g', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '8gxb', 'qjlsawsp', 476.853022, 'i3hl7j', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', '3y795ybv', '3kr3w4jn2', 831.711295, '9xgjjac', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_40', '6lu2c', 'l8', 679.529504, 'fc', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_41', 'fmbgz5o', 'xs27x', 797.293299, '88y1k253s', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_42', '5', 'ls1ehn1md', 714.004082, 'q', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_43', '4hmnnw4m0', 'rwbjk', 416.914046, 'h6gd', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_44', 'b7jjpl', 'tlzh42', 599.723985, 'yj5y', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'a38gfxswb2d', 'zmxwdb7', 845.028228, 'tp5q', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_46', '1k4c', 'gwnkd4kc3', 703.092435, 'kax', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_47', 'r90nhsp', 'gobb6nrn5', 319.952055, 'phy', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_48', 'x8scr0f', '3qn0b', 835.467188, 'm2rlxcrw', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_49', 'x0', '3rzgz84lqm', 73.031578, 'wb1b3vun66e0', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_50', 'i90o50q833g', '865zm6dpewew', 618.342373, '2p40u2vil', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_51', 'iqoauy0', '3lwh994f', 605.87061, 'qc1m9gr8xjq', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'bloxd4sj5il9', 'nd6dvy', 830.119213, 'gwakmwgw73f', 'O', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'fbl10q', '6j6d4f', 704.233498, '5m4s2ajdu', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_54', '6xuj90te', 'x3', 321.062263, '7709qf', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_55', '9lx8qzabiv', 'umwu7a', 173.728467, 'jwk6hh2', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_56', '1ll930', 'vkviql', 832.919244, 'n0rlpsaxeei', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_57', 'mbci', '5ojsme', 258.185896, 'r3uxdoxa', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_58', 'sbh72', '404qpp3303a1', 213.090413, 'ut818', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_59', 'wvadbp0760', 'gk2hjz', 368.492978, '1l', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_60', 'g8dw16f5tq', 'jd', NULL, 'mabmkr2t', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_61', 'dlb6i42', 'tew5c29d', NULL, 't1havc', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_62', 'c4zpw867', 'fve0jf4i', 498.716249, '99kvn', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_63', 'h', 'i6tp3t', 88.511849, 'dtw89qy6sru4', 'A', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_64', '8u5lvdbp', '3cehye3oylc', NULL, 'if0', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_65', 'ly46upleoh', 'm3q0pq97', NULL, '534', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_66', '5xb', '11y', 892.402234, 'zc7x', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_67', 'g', 'xt0twou', 952.316709, 'yi4h5c4f', 't1__ead899', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_68', '8s82sp4j9fo', 't', NULL, 'kcq2iae6a', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_69', '6ql', '676lk8q', NULL, 'azkjyfxsov', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_70', '98', '8', 940.248183, '0235v8ik', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_71', '3qu7', 'cxswgr124', 339.65676, 'u6v8hklzy93z', 't1__ead899', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_72', 'smdhctnj', 'y6whwhlh5', NULL, 'i1dtdjm8ry9l', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_73', 'hw6lv7j452', '1qz', NULL, 'qt5uw42p20', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_74', 'wt', 'hk', 432.054593, '3bj', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_75', 'suy', '6h', 910.141299, 'boodlz6', 't1__ead899', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_76', 'fghixb', 'gxislq', 441.381061, 'dq44u', 't1__1f0a77', 't1__28187a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_77', '2fkzbwx3q5b', '37qob', 748.384773, 'vbj26kpxc5', 't1__994a5c', 't1__d94bbc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_78', '7pvp0h2fl', 'tlco', 279.402434, 'tl1uo', 'A', 't1__d94bbc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('p5qi2rkf9v', 'x58pz', 'v')
('a7ryfd', 'z16ni', 'yzt1afgogrit')
('foa', 'cd07z2zezjo7', '3lq')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('q51oa2sb3u', 'i1pa', 'mjwpp2')
('1', 'j', '521gwnlas6e')
('pmpjjvec', 'trn6j72v', '5b733o58z')
*/

-- Prediction Query
SELECT member.first_name, member.last_name, member.phone FROM member INNER JOIN expense ON member.member_id = expense.link_to_member WHERE expense.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('p5qi2rkf9v', 'x58pz', 'v')
('a7ryfd', 'z16ni', 'yzt1afgogrit')
('p5qi2rkf9v', 'x58pz', 'v')
('foa', 'cd07z2zezjo7', '3lq')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('p5qi2rkf9v', 'x58pz', 'v')
('q51oa2sb3u', 'i1pa', 'mjwpp2')
('p5qi2rkf9v', 'x58pz', 'v')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('p5qi2rkf9v', 'x58pz', 'v')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('p5qi2rkf9v', 'x58pz', 'v')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('p5qi2rkf9v', 'x58pz', 'v')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('p5qi2rkf9v', 'x58pz', 'v')
('p5qi2rkf9v', 'x58pz', 'v')
('1', 'j', '521gwnlas6e')
('p5qi2rkf9v', 'x58pz', 'v')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('pmpjjvec', 'trn6j72v', '5b733o58z')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
('pmpjjvec', 'trn6j72v', '5b733o58z')
('t3__e445d6', 't3__74e9fc', 't3__396aec')
*/