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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (31, 65, 'Why square the difference instead of taking the absolute value in standard deviation?84', 84);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (30, 84, 'Why square the difference instead of taking the absolute value in standard deviation?84', 84);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (75, 79, 84, 76, 'Why square the difference instead of taking the absolute value in standard deviation?102', 77, 'Why square the difference instead of taking the absolute value in standard deviation?78');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (83, 79, 84, 82, NULL, 81, 'Why square the difference instead of taking the absolute value in standard deviation?80');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (57, 58, 84, 59, 'Why square the difference instead of taking the absolute value in standard deviation?60', 61, 'Why square the difference instead of taking the absolute value in standard deviation?62', NULL, 'Why square the difference instead of taking the absolute value in standard deviation?63');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (64, 79, 65, 66, 'Why square the difference instead of taking the absolute value in standard deviation?67', 68, 'Why square the difference instead of taking the absolute value in standard deviation?69', NULL, 'Why square the difference instead of taking the absolute value in standard deviation?70');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (33, 79, 79, 84, 84);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (32, 79, 79, 84, 84);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (58, 84, 84, 40, 41, 42, 43, 44, 'Why square the difference instead of taking the absolute value in standard deviation?45', 46, 'Why square the difference instead of taking the absolute value in standard deviation?', 'Why square the difference instead of taking the absolute value in standard deviation?47', 48, 49, 50, 51, 52, 53, 54, 'Why square the difference instead of taking the absolute value in standard deviation?55', 'Why square the difference instead of taking the absolute value in standard deviation?56');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (79, 84, 84, 85, 86, 87, 88, 89, 'Why square the difference instead of taking the absolute value in standard deviation?90', 91, 'Why square the difference instead of taking the absolute value in standard deviation?', 'Why square the difference instead of taking the absolute value in standard deviation?92', 93, 94, 95, 96, 97, 98, 99, 'Why square the difference instead of taking the absolute value in standard deviation?100', 'Why square the difference instead of taking the absolute value in standard deviation?101');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (35, 79, 'Why square the difference instead of taking the absolute value in standard deviation?84', 84, 84);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (34, 79, 'Why square the difference instead of taking the absolute value in standard deviation?84', 84, 84);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (65, 84, 84, 'Why square the difference instead of taking the absolute value in standard deviation?84', 84, 'Why square the difference instead of taking the absolute value in standard deviation?84', 'Why square the difference instead of taking the absolute value in standard deviation?84', 'Why square the difference instead of taking the absolute value in standard deviation?84', 84, 84, 84, 84, 84, 'Why square the difference instead of taking the absolute value in standard deviation?84');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (84, 84, 84, 'Why square the difference instead of taking the absolute value in standard deviation?84', 84, 'Why square the difference instead of taking the absolute value in standard deviation?84', 'Why square the difference instead of taking the absolute value in standard deviation?84', 'Why square the difference instead of taking the absolute value in standard deviation?84', 84, 84, 84, 84, 84, 'Why square the difference instead of taking the absolute value in standard deviation?84');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Comment FROM posts AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.PostId WHERE T1.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT c.Text FROM comments AS c JOIN posts AS p ON c.PostId = p.Id WHERE p.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Prediction Result:
('Why square the difference instead of taking the absolute value in standard deviation?102',)
(None,)
*/