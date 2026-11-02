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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1910425938, -845863578, '2011-01-01 00:00:00+00:00', -1610064545, 20001, 'n', 1, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1116181514, 1255852738, '2011-01-01 00:00:00+00:00', -1555456236, 20001, 'kf9vq', 2, '2025-02-21 13:28:29+00:00', 'x58pz0f8jeg', 'd21vy9uxj4hw', -2050247126, -736979194, 2103044118, 2, '2020-12-31 11:15:26+00:00', '2023-09-26 13:08:37+00:00', 1298861365, '2020-07-01 12:41:54+00:00', 'wnqcx', '5hncprjtu0d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -1748371085, -1742081330, '2011-01-01 00:00:00+00:00', 894242932, 20001, 'f3dqv0gc', 2, '2020-04-02 07:45:47+00:00', '8ozk3zbil', 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, 2, '2024-06-08 00:23:27+00:00', '2023-02-17 08:54:45+00:00', -541746689, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 76996700, -435350511, '2011-01-01 00:00:00+00:00', 1992637800, 20001, 'dctmf', 4, '2020-11-14 00:31:21+00:00', '2g0v5q8qd', 'jpe1io22785', 2119806856, -1962347906, -866772222, 1, '2022-01-28 18:02:07+00:00', '2025-12-22 07:46:37+00:00', 1582582341, '2025-02-24 17:48:00+00:00', 'g6bno', '5zi36c');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -2072838897, -1173368267, '2011-01-01 00:00:00+00:00', 382831862, 20001, '0', 4, '2025-09-08 19:36:12+00:00', 'z2zezjo7w', 'xd', 1999335832, -526612570, -546516406, 4, '2021-08-06 04:52:45+00:00', '2022-04-20 03:52:20+00:00', 983324983, '2021-12-02 15:45:50+00:00', 'ztdgj5i3lq5l', 'pim5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1379859112, 195202164, '2011-01-01 00:00:00+00:00', 1817366143, 20001, '7p2r94gt', 4, '2020-12-28 23:17:24+00:00', '2mnajjla3o', 'v8u', 618058035, 1553368934, -1252009958, 2, '2024-03-25 10:50:51+00:00', '2024-11-14 17:33:35+00:00', 1908593332, '2020-09-26 00:22:30+00:00', 'yz7zzb', '8y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -72442907, -2060082151, '2011-01-01 00:00:00+00:00', -1122409769, 20001, 'u', 1, '2022-05-31 03:34:18+00:00', 'auvmkrpd', 'wzw', -55494714, -1674145149, 234957614, 3, '2025-11-19 09:24:25+00:00', '2021-11-30 22:01:43+00:00', -354292049, '2025-06-30 18:54:45+00:00', '9', '0jxf');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1793230843, -441521858, '2011-01-01 00:00:00+00:00', 2015094998, 20001, '2zobb0q0k32o', 1, '2020-06-28 23:31:51+00:00', 'cl5ams', 'orlwyngc1dj', 211603887, -413043724, 761519897, 2, '2023-08-24 14:09:34+00:00', '2023-04-06 19:38:57+00:00', -1156828895, '2023-04-04 11:32:59+00:00', 'o6l0hdt6fu', 'yxuzk');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -670154354, -2140468103, '2000-03-01 23:59:59+00:00', 469838697, 20001, 'lboeowii1z5', 1, '2021-10-05 09:01:22+00:00', 'xih662q2xly', 'otow9oaawg', 1044710644, 966412849, -2061634386, 1, '2022-07-26 21:24:54+00:00', '2020-02-29 08:50:35+00:00', -1216952047, '2023-05-07 05:01:37+00:00', '9tajz9td', 'n5wcgumbc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, 1147652228, 1378873397, '2011-01-01 00:00:00+00:00', 1964331395, 20000, 'bd0w9603v', 1, '2023-05-02 20:56:40+00:00', 'xw1rxe9yfk7', 'k162n', -516345261, -1191116453, 1709667347, 4, '2022-09-26 18:21:28+00:00', '2023-07-30 22:23:05+00:00', 30861410, '2023-05-21 01:39:33+00:00', '3', 'rmkio18r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2011-01-01 00:00:00+00:00', 1, NULL, 'value', 5, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1833165707, 1155439218, '2000-08-31 00:00:00+00:00', 1313172851, 20000, 'm52zbu', 6, '2021-11-30 23:39:10+00:00', 'nrqrofqy', '5s5b', 2107872094, 882961052, 743312762, 5, '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00', -751275471, '2021-08-01 11:21:15+00:00', 'qa1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2090-08-31 23:59:59+00:00', 1, NULL, 'value', 7, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1, 1, NULL, 1, 20001, 'value', 8, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 3, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1, 1, NULL, 1, 20000, 'value', 9, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 7, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, NULL, 1, NULL, 'value', 10, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 10, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 600401919, -1437333179, '2011-01-01 00:00:00+00:00', -921145356, 20001, 'qcgsk9', 11, '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 1644814318, 1465859724, -1349201381, 10, '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00', 1526238907, '2021-07-11 07:27:32+00:00', 'tilbn', 'rmdp');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__ab6548', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1585009206, '2021-08-19 01:10:02+00:00', 't1__ab6548', '2024-10-24 14:16:53+00:00', '2zbuo4nr', 'qrofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1644911394, '2021-12-11 04:26:48+00:00', 't1__ab6548', '2024-09-13 14:36:04+00:00', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 2142703426, -533293970, 176380444, '9rljsl0b4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1746373317, '2020-07-12 19:51:25+00:00', 'h5ogrgjd8yz', '2022-08-16 10:09:33+00:00', '1afgogritsj', 'ayxp1q43', '1jh3den', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 2122220075, '2022-01-03 02:42:55+00:00', 'luhvdltti', '2021-07-20 10:41:36+00:00', 'n', 'rmdp', 'siie', -45536098, 1861536320, 44952191, 1151980946, 1620389964, '00t5c4ecigc');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1666765085, '2025-11-19 11:50:18+00:00', '2klex14ji', '2025-02-02 04:37:17+00:00', 'zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1529584866, '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', '2020-03-11 08:08:02+00:00', 'v', 'ph2', 'nd', -1052964641, -1245682094, -1660358170, -1106350634, -1509264256, '0dz79f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -1742081330, '2024-08-10 07:57:32+00:00', 'n2f3dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -1888505890, '2025-10-16 14:52:58+00:00', '16nijja', '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '8', 'yzt1afgogrit', 678047687, -1478134144, -491938169, -106471771, 1235416111, 'jh3den8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T2.CreaionDate) = '2011' AND T2.ViewCount > 20000;

/*
Gold Result:
('t1__ab6548',)
('t1__ab6548',)
('t1__ab6548',)
('h5ogrgjd8yz',)
('h5ogrgjd8yz',)
('h5ogrgjd8yz',)
('t1__ab6548',)
('t1__ab6548',)
(None,)
*/

-- Prediction Query
SELECT users.displayname FROM users INNER JOIN posts ON users.id = posts.owneruserid WHERE posts.viewcount > 20000;

/*
Prediction Result:
('t1__ab6548',)
('t1__ab6548',)
('t1__ab6548',)
('h5ogrgjd8yz',)
('h5ogrgjd8yz',)
('h5ogrgjd8yz',)
('t1__ab6548',)
('t1__ab6548',)
('t1__ab6548',)
('d21vy9uxj4hw',)
(None,)
*/