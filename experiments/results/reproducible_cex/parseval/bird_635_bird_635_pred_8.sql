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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 944975670, -1575410149, '2024-05-05 04:13:50+00:00', 1944978593, 1722106924, 'f', 1, '2021-05-31 16:00:51+00:00', 'oa', 'cd07z2zezjo7', 304189298, -542502665, 1999335832, 1, '2023-03-18 12:07:22+00:00', '2022-06-10 06:35:27+00:00', -546516406, '2021-08-06 04:52:45+00:00', '0oztd', 'j5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1405314653, 1816660482, '2021-07-27 00:10:12+00:00', 1339733032, -1556979799, 'k58qs27p', 5, '2023-11-07 06:34:01+00:00', '94gth', '2mnajjla3o', -1428186898, -761353513, 362376128, 1, '2024-12-23 03:48:38+00:00', '2024-10-19 09:01:03+00:00', -1311735207, '2023-10-19 18:37:00+00:00', 'e578', 'fvy');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1294064538, 778835680, '2023-05-18 17:35:26+00:00', 1262491793, 450555855, '1gwnlas6', 5, '2025-03-08 07:37:26+00:00', 'lb', 'eowi', -1610380698, -457369423, 1557188093, 5, '2025-05-04 13:24:05+00:00', '2023-02-18 23:14:50+00:00', -1552469358, '2024-05-19 10:57:10+00:00', '2q2xlyoto', '9oaawg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 389700824, -1853955201, '2022-08-28 09:41:49+00:00', -1051623642, 2013745856, 'b', 1, '2023-03-16 17:59:19+00:00', 'mzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 1106724223, 5, '2025-06-29 15:21:32+00:00', '2023-03-26 14:26:48+00:00', 1487347213, '2023-03-15 00:23:20+00:00', 'yd1jmgjach8', 'qta8y3a17v4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 6, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Matt Parker', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -688509700, '2025-07-25 08:53:04+00:00', 'Matt Parker', '2024-12-24 08:25:52+00:00', '9uxj4hwbdvlp', 'h2gndqwnqcx5', 'hncprjtu0dz', -1748371085, -1742081330, 894242932, -211209314, -1056308489, 'gcb98oz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -2078052421, '2021-07-02 01:45:48+00:00', 'yrkn6vck6ah0', '2020-10-15 18:29:15+00:00', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', 2011234363, -1483100200, -7597509, -1625552518, -1738458256, 'jd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, -55602865, '2024-02-19 01:18:26+00:00', 'Matt Parker', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -1666765085, 1, '72klex14ji7z', '2023-01-02 05:47:29+00:00', 1, 'au2dwyrq13', 'yu78', '9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 244829661, 1, 'jsl', '2023-07-26 21:52:05+00:00', 1, '4', 'p5qi2rk', '9v');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1074760385, 1, 't1afgog', '2022-05-19 02:17:07+00:00', 6, 'tsj', 'ayxp1q43', '1jh3den');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, 357330522, 1, '68x8vacx7a', '2020-10-05 17:58:46+00:00', 6, '5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -1744557630, 1, '5q8qdj', '2021-12-29 21:32:16+00:00', 6, '1i', '2278', '07cvtjpt');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -451030047, 6, 'be8yvkv42q7', '2022-05-28 06:47:17+00:00', 1, '58b4pm', 'u', '3auvm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 274891948, 6, 'pdjwzw5chn9', '2021-08-16 22:45:01+00:00', 1, 'o705a9n0jxfo', 'ws', 'do2zobb');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, -397848196, 6, '0k32odwcl5a', '2025-04-19 10:34:51+00:00', 1, 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483639, 1044710644, 7, 'qb0tbindz39t', '2020-01-05 17:53:54+00:00', 1, 'z9t', '8', '5wcg');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483638, -794767771, 7, 'c', '2025-11-17 06:38:18+00:00', 1, '3tdu6bd0w9', '03vzxw1rx', '9y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, -1046720861, 7, '162nh55y3d', '2025-02-15 07:25:43+00:00', 1, 'hvu0', 'dza35rmki', '18ri');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, 1432875972, 1, 'dpuap96rnt', '2020-06-09 09:52:21+00:00', 6, 'rhm5w', 'ic7', 'dn2np490xdm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, 1996699977, 1, 'tgelc', '2022-09-26 08:18:54+00:00', 6, 'qb9i9f2ccu', 'jq1', 'uik1y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, 775289854, 1, '0', '2024-07-31 14:48:12+00:00', 6, 'ls', 't1pqomiztvb6', '4iz7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483633, 190510318, 6, 'tb8r9114qbre', '2025-08-27 08:26:07+00:00', 1, 'bjeuuwsj8', 'jh8', 'wpxlvris');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483632, 2042428747, 6, 'z0kaq', '2022-08-19 06:04:31+00:00', 1, 'ncgc8s3b7v', '88kwdmdbdht6', 'j47nxar50h');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483631, 460471995, 6, 'han', '2023-05-02 01:41:48+00:00', 1, 'dpunmw', 'wx', 'rlawk');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483630, 572453185, 7, 'tsmg9', '2024-07-01 17:30:12+00:00', 1, 'aqz2o20pj6d', 'dlysu6iphd', 'u2g');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483629, 1352531282, 7, 'vwq51oa', '2023-10-05 21:08:15+00:00', 1, 'sb3uoi1pavcv', 'wnyqrouirlrp', 'ouit63xyfvmj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483628, -614741184, 7, '26mb', '2023-12-03 17:16:54+00:00', 1, 'j', '0ju0h3r133ir', 'axyyhpl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483627, -1452518801, 1, 'tsr54o', '2024-04-15 07:19:04+00:00', 6, 'jektb', '1d2nzg3rjk', 'ns47j2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483626, -1517668312, 1, '8dccy3vjwq49', '2024-12-19 08:25:50+00:00', 6, 'yrnxs6dvdx', 'o', 'v7t3gvpl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483625, -1789708299, 1, 'uun7k1', '2023-07-03 03:04:20+00:00', 6, 'z2my1ogyv1r', 'ez', 'x');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483624, -1131290294, 6, 'ly78oitxeilp', '2025-01-15 04:29:10+00:00', 1, 'e019cy7od033', 'dlhdsvnhed29', 'qv2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483623, 1032462616, 6, '331spxpw30bg', '2023-01-18 16:20:20+00:00', 1, 'xgi', 'nlj6idmp61', '2o3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483622, -2106733603, 6, '62ocagj', '2020-07-25 01:29:32+00:00', 1, 'vx', 'xlu49ku', 'o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483621, -775706063, 7, 'khllbwvdpu', '2025-09-21 11:33:46+00:00', 1, 'v0eduy9v', 'z129835x', 'epac');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483620, 1372042958, 7, 'b', '2023-10-26 01:34:06+00:00', 1, '0c', '96xiyet8', 'jhcf46');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483619, -2003500453, 7, 'perxa61sjv', '2024-08-21 15:02:01+00:00', 1, 'v3dd', 'okuez', 'ctehia3cmvb');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483618, -1977676789, 1, 'ffwor1', '2020-07-31 19:24:59+00:00', 6, 'ksf9q', '2qg01huij', '7f8kqhiu5g');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483617, -1728059226, 1, '5', '2025-08-26 04:11:20+00:00', 6, 'qjlsawsp4kwi', 'hl7j43y7', '5ybv83kr3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483616, 722968762, 1, 'jn2z19xg', '2021-04-19 17:13:53+00:00', 6, 'jacgmukfb5', 'f41', '80terbfokvee');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483615, -1374901328, 6, 'cel8mhfc', '2021-03-07 12:32:20+00:00', 1, 'n5en', 'i0f', 'bgz5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483614, 1778447090, 6, 's27xh8', '2024-07-31 08:20:26+00:00', 1, 'y1k253sb5', 'ls1ehn1md', 'aqqhyyzsnp64');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483613, -1669961050, 6, 'nw4m', '2023-07-29 03:07:11+00:00', 1, 'rwbjk', 'bph6gdw', '7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483612, 1297861259, 7, 'h42nyj5', '2023-04-07 01:15:04+00:00', 1, 'rji5mqkna3', '8gfxswb2d0zm', 'wdb7ot');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483611, 619382464, 7, '5qo1k4c6gwn', '2025-04-29 22:52:55+00:00', 1, 'd4k', 'c3iikaxzr9', '0nhsp9gobb6n');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483610, 1144243962, 7, '5ujp', '2021-01-15 17:18:04+00:00', 1, 'bnaayvh', 'vyx8scr0fs3', 'qn0b5m2rlxcr');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483609, -964661721, 1, 'z8', '2024-01-30 23:52:27+00:00', 6, 'lqme2wb1b3', 'un66e0', 'mol');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483608, 1270732094, 1, '70zi90o', '2024-03-17 03:22:57+00:00', 6, 'q833g86', '5zm6dpewew0', '2p40u2vil');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483607, -261109897, 1, 'sad6q5', '2023-05-03 02:55:46+00:00', 6, 'qoa', 'uy023lwh99', 'fqc1m9gr');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483606, -1172741948, 6, '4', '2022-05-31 20:03:13+00:00', 1, '5il', 'wnd6dvygw', 'akmwgw73fy3d');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483605, -1436037867, 6, 'ptx', '2020-10-01 23:52:35+00:00', 1, 'bl10qx6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483604, -199427879, 6, 'u7709qf9', '2021-08-03 01:21:55+00:00', 1, '8qzabi', 'uumwu7', 'l');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483603, 55189176, 7, '2o', '2020-08-08 13:53:06+00:00', 1, '9350fzrv1', 'l93', '0xvkviql6n0r');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483602, 641545472, 7, 'xeeinmbciv5', '2021-11-22 19:31:21+00:00', 1, 'sme', 'v3r3u', 'doxa0o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483601, 858882953, 7, 'zmjrssb', '2021-01-03 05:47:09+00:00', 1, '2404qpp33', '3a1ngqu', '8184d');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -1408342453, 1, 'dyxk', '2025-03-03 11:52:29+00:00', 1, 'a0cql1c', 'cwvadbp07', '0ugk2hjzx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -1123211891, 1, 'lcg9a4g', '2021-05-16 08:00:49+00:00', 1, 'jog8dw16f5', 'qhjd5', 'abmk');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483600, -976424792, 1, 'tzdlb6i422te', '2025-06-19 15:20:45+00:00', 1, 'w5c29dwt1h', 'v', 'c2c4zpw8672');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483597, -1748913439, 1, '5t9', '2025-04-07 12:27:48+00:00', 1, 'kvnbhvi6t', '3tfn', 'dtw89qy6sru4');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483596, 1474709013, 1, 'bp9qgjrad', '2025-04-24 19:18:53+00:00', 1, 'hj', '8zr6k53p8e5o', 'f0y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483595, -327742602, 1, 'r8kzi0g50j5', '2024-09-12 03:12:10+00:00', 1, 'fznqcuex4', 'faxc1je', '48u5lvdb');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483594, 1337608681, 1, '3cehye3oylc', '2021-02-12 16:24:21+00:00', 1, 'if0ly46upl', 'eoh3m3q0pq97', '534');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483593, 1686931087, 1, 'v4pmp', '2021-03-30 15:10:13+00:00', 1, 'vec', 'trn6j72v', 'kwegrf6snl45');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483592, 1652097981, 1, 'wo', '2021-04-10 19:11:33+00:00', 1, 'nhh6va3tdx5', 'n7', 'b733o58z');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483591, 1737246157, 1, 'oua4yi', '2025-12-31 21:48:56+00:00', 1, 'h5c4f1q9', '43ial8', 's82sp4j9fo');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483590, 1090670329, 1, '2iae6', '2020-02-09 03:23:00+00:00', 1, '6ql', '676lk8q', 'azkjyfxsov');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483589, 1450500765, 1, '0235v8ikp3qu', '2024-12-05 22:49:20+00:00', 1, '7cxswgr12', 'vu6v8hkl', 'y93zu8y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483588, -1134421846, 1, '5s', '2021-08-14 17:50:13+00:00', 1, 'h', 't', 'nj8y6whwhl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483587, -1931468427, 1, 'j', '2021-09-07 12:08:47+00:00', 1, '8ry9lhw6lv7', '452', '1qz');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483586, -665597852, 1, 'p20gwtfh', '2021-05-02 11:26:08+00:00', 1, 'l3bjksu', 'e6hvzbo', 'dlz6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483585, 822981708, 1, 'ijufc2vfghi', '2023-02-16 02:35:18+00:00', 1, 'u', 'xi', 'lq2is');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483584, -69826970, 1, '2fkzbwx3q5b', '2022-05-04 17:16:39+00:00', 1, '7qobvbj2', 'kpxc567pv', '0h2f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483583, 909468880, 1, 'qtl1u', '2021-11-18 13:18:45+00:00', 1, 'dbvf3ya6l4', '1gfeg6q6', 'if');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483582, -293052318, 1, 'jf1qj3se4d', '2022-01-13 08:09:21+00:00', 1, '4', '6ru', 'rl72q8ippxb6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483581, -1434769338, 1, 'j4ce2y48', '2024-03-12 10:17:13+00:00', 1, 's1gz7p3', 'vg', 'wytzip2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483580, 701987743, 1, 'd2hqs4zc1', '2024-09-13 23:56:32+00:00', 1, '282rnfvk', 'mfoqp', 'ucnn53i');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483579, 178068376, 1, 'qwx0hv', '2022-10-25 06:16:23+00:00', 1, 'oh59ivn', 'ipn6drokt1', '6hqb9jae9ps4');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483578, 1039998344, 1, 'qku', '2021-01-23 23:52:23+00:00', 1, 'zi62308npq', 'dbwew42zl4p', 'f8ul0');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483577, -1400434743, 1, 'p', '2020-04-23 06:00:58+00:00', 1, 'w1gno6r9d3zd', 'y', '5uhorv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483576, -582426548, 1, 'd', '2021-09-27 07:44:10+00:00', 1, 'o47', 'q', '0691b7s1i');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483575, 2115162734, 1, '8th', '2022-03-14 11:45:55+00:00', 1, '3rs94x3', 'yxg3ufg', 'efrzw0qgiqh4');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483574, 1840016318, 1, '3k79', '2022-10-28 01:14:51+00:00', 1, '9407swb', '349kf5l6', 'nd3rh');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483573, -703840785, 1, '122bvxjnuw84', '2021-03-29 08:25:30+00:00', 1, '31nf', 's4niom2u85b', '2971k');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483572, -1505803580, 1, 'bssy', '2024-06-21 11:40:26+00:00', 1, 'w5nagrj6', '317k', 'j');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483571, 98755104, 1, 'iuj9f', '2025-04-20 04:48:32+00:00', 1, '45ycwnr8d', '5gbzj', 'euvj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483570, 881719347, 1, '8am0qju', '2022-07-31 20:23:32+00:00', 1, 'f316fr11', 'uvk', 's7wggg30');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483569, -435550780, 1, 'dq', '2024-12-30 14:15:39+00:00', 1, 'orxze42lw', 'enn4ilc3kspw', 'gvoc9l5zm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483568, -1001569685, 1, '641h6b', '2023-09-13 09:34:21+00:00', 1, 'ugt8ygqofzr1', 'v7z6i', 'r1w');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483567, -418713192, 1, 'k', '2023-09-29 17:49:00+00:00', 1, 'zzuuwyewb', 'hg8', '1ev3gqe');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483566, -237981586, 1, 'hc', '2021-10-05 17:15:52+00:00', 1, 't2v4lraxg0g', 'xot6v', '1lrh');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483565, -524520263, 1, 'beyhmlrnycz8', '2020-06-26 02:24:21+00:00', 1, 'ykabtcpo', '1ke8euy0kcx', '8e4');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -443340271, 2, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 0, 's5bbp02e', 'tliqa1', 'ryytoo3');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1, 1, 537874887, '2024-05-26', 1, -1529584866);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, 1, -56541423, '2020-03-07', 1, -316558073);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, 2, 226938182, '2022-02-06', 5, 1178636309);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id INNER JOIN votes AS T4 ON T4.PostId = T3.Id WHERE T1.DisplayName = 'Matt Parker' GROUP BY T2.PostId, T4.Id HAVING COUNT(T4.Id) > 4;

/*
Gold Result:
(39,)
(39,)
*/

-- Prediction Query
SELECT COUNT(*) FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id JOIN votes AS v ON p.Id = v.PostId WHERE u.DisplayName = 'Matt Parker' GROUP BY p.Id HAVING COUNT(v.Id) > 4;

/*
Prediction Result:
*/