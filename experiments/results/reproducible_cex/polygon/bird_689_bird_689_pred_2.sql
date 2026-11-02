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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (39, 183, '183', 183);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (42, 37, 183, 183, '183', 183, '183');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (41, 183, 183, 183, '183', 183, '183');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (36, 37, 183, 183, '183', 183, '183', '183', '183');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (35, 37, 38, 183, '183', 183, '183', '183', '183');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (44, 183, 37, 183, 183);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (43, 37, 37, 183, 183);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (183, 183, 183, 82, 83, 84, 85, 86, '87', 88, '89', '90', 91, 92, 93, 94, 95, 96, 97, '98', '99');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (37, 183, 183, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (46, 37, '183', 183, 183);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (45, 37, '183', 183, 183);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (38, 183, 183, '183', 183, '183', '183', '183', 183, 183, 183, 183, 183, '183');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (183, NULL, NULL, '100', NULL, NULL, '101', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (48, 37, 183, 183, '1000-07-03', 183);
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (47, 183, 38, 183, '1000-07-03', 183);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.Id = 183 ORDER BY T1.LastEditDate DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('100', '101')
*/

-- Prediction Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 INNER JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Id = 183;

/*
Prediction Result:
('100', '101')
*/