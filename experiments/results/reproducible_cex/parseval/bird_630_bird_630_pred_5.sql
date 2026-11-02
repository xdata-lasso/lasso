-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 't3__c252d8', 1151980946, 1620389964, 546571701, 1, '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00', 947159877, '2022-07-16 22:41:51+00:00', 'c4ecigce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 556727997, 1178000634, '2024-08-09 01:13:45+00:00', 537874887, -461695645, 'f8jegd21vy9u', -2147483647, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 't3__c252d8', -261132974, -1264842910, -1052964641, 1, '2021-10-14 08:16:37+00:00', '2022-02-18 09:12:59+00:00', -1660358170, '2020-05-10 07:36:02+00:00', 'rjtu', 'dz79fjg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1382410067, '9', 1, '2024-08-05 04:49:57+00:00', 'zk3z', 't3__c252d8', 1686459626, -1554531873, 982314585, -2147483647, '2022-05-18 00:14:53+00:00', '2021-06-12 16:42:05+00:00', 32204797, '2020-04-16 10:31:38+00:00', '6ah', 'f8jswwl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 600440952, 1568069663, '2020-09-12 13:47:57+00:00', -1717646459, -1696173285, 'tsj', -2147483647, '2023-11-11 06:21:01+00:00', 'y', 'p1q430', 1923912467, 518609210, 1948383687, -2147483647, '2020-06-27 17:29:33+00:00', '2020-08-20 06:07:09+00:00', 195720193, '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -233617564, 79330142, '2023-02-22 13:15:37+00:00', 756202403, 782684333, 'pmaus3au', 4, '2022-11-13 09:18:31+00:00', 'krpd', 'wzw', -55494714, -1674145149, 234957614, 3, '2025-11-19 09:24:25+00:00', '2021-11-30 22:01:43+00:00', -354292049, '2025-06-30 18:54:45+00:00', '9', '0jxf');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1437333179, -921145356, '2023-01-16 20:10:41+00:00', -1022641847, -1726781632, '9n8', 4, '2020-04-30 23:22:06+00:00', 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', 'dpos');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 1, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 5, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'John Salvatier', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1666765085, '2025-11-19 11:50:18+00:00', 'John Salvatier', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -241848752, '2024-05-29 05:19:47+00:00', 'John Salvatier', '2024-08-24 21:14:31+00:00', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -1950324754, 2115816682, 76987628, -253138337, 641521863, 'o7w');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -57705450, '2022-06-10 06:35:27+00:00', 'cmr0oz', '2022-07-12 13:13:05+00:00', 'g', '5i3', 'q5l', 1339733032, -1556979799, -55240145, 1379859112, 195202164, 's27p2r94gth2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'John Salvatier', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 1255343543, 2, '7', '2025-04-29 15:45:27+00:00', 1, '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 76996700, 3, 'o72ctdc', '2022-08-05 18:12:12+00:00', 1, 'mfg62g0v5q8q', 'j', 'e1io');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1162591638, 1, 'ajjla3okv8u', '2022-08-27 04:45:18+00:00', 4, 'tmu2ne578l', 'vy', '7zzbe8y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1165594842, 4, 'szdo2z', '2024-10-15 01:24:38+00:00', 1, 'bb0q', '0k32odwcl5a', 'msorlwyngc');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, 453340472, 1, '9erhizgk1yoe', '2023-04-04 11:32:59+00:00', 4, 'o6l0hdt6fu', 'yxuzk', '5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -1686002788, 4, 'las6', '2025-03-08 07:37:26+00:00', 1, 'lb', 'eowi', '1z5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -1552469358, 1, '62q2xlyot', '2025-07-02 03:36:52+00:00', 4, 'w9oa', 'awg96aqb0tbi', 'ndz39tajz9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 152478847, 4, '5wcgumbc3td', '2024-11-28 14:19:46+00:00', 1, '6bd0w9', '03vzxw1rx', '9y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 125495479, 1, '162', '2021-10-24 14:42:01+00:00', 1, '55', '3dohvu0', 'dza35rmki');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -1160642134, 1, 'ri2hy08ft', '2022-01-15 16:05:02+00:00', 1, 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 357443379, 1, 'gjac', '2020-12-11 19:02:49+00:00', 1, 'qta8y3a17', 'v4ygmayq3qdp', 'uap96rntdqr');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1576219117, 5, '5u', '2021-11-09 05:42:50+00:00', 2, '6klfa9', '00t5c4e', 'cigce376nium');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -1377057208, 6, 'ilbnp', '2022-04-12 01:47:28+00:00', 5, 'dpos', 'ie5', 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'John Salvatier';

/*
Gold Result:
('t3__c252d8',)
('t3__c252d8',)
('p1q430',)
('wzw',)
('wzw',)
('wzw',)
('t3__c252d8',)
('t3__c252d8',)
('t3__c252d8',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT posts.tags FROM posts INNER JOIN users ON posts.owneruserid = users.id WHERE users.displayname = 'John Salvatier';

/*
Prediction Result:
('t3__c252d8',)
('p1q430',)
(None,)
*/