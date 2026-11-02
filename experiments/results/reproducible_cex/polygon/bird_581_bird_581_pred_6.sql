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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (38, 65, 'Open source tools for visualizing multi-dimensional data?102', 102);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (37, 65, 'Open source tools for visualizing multi-dimensional data?102', 102);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (40, 64, 65, 102, 'Open source tools for visualizing multi-dimensional data?102', 102, 'Open source tools for visualizing multi-dimensional data?102');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (39, 89, 102, 102, 'Open source tools for visualizing multi-dimensional data?102', 102, 'Open source tools for visualizing multi-dimensional data?102');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (36, 89, 102, 102, 'Open source tools for visualizing multi-dimensional data?102', 102, 'Open source tools for visualizing multi-dimensional data?102', 'Open source tools for visualizing multi-dimensional data?102', 'Open source tools for visualizing multi-dimensional data?102');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (35, 89, 102, 102, 'Open source tools for visualizing multi-dimensional data?102', 102, 'Open source tools for visualizing multi-dimensional data?102', 'Open source tools for visualizing multi-dimensional data?102', 'Open source tools for visualizing multi-dimensional data?102');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (42, 89, 89, 102, 102);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (41, 89, 89, 102, 102);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (64, 102, 65, 66, 67, 68, 69, 70, 'Open source tools for visualizing multi-dimensional data71', 72, 'Open source tools for visualizing multi-dimensional data', 'Open source tools for visualizing multi-dimensional data73', 74, 75, 76, 77, 78, 79, 80, 'Open source tools for visualizing multi-dimensional data81', 'Open source tools for visualizing multi-dimensional data?82');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (89, 102, NULL, 87, 86, 85, 84, 83, 'Open source tools for visualizing multi-dimensional data?90', 91, 'Open source tools for visualizing multi-dimensional data', 'Open source tools for visualizing multi-dimensional data?92', 93, 94, 95, 96, 97, 98, 99, 'Open source tools for visualizing multi-dimensional data?100', 'Open source tools for visualizing multi-dimensional data101');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (44, 89, 'Open source tools for visualizing multi-dimensional data?102', 102, 102);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (43, 89, 'Open source tools for visualizing multi-dimensional data?102', 102, 102);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (102, 103, 104, 'Open source tools for visualizing multi-dimensional data115', 105, 'Open source tools for visualizing multi-dimensional data?106', 'Open source tools for visualizing multi-dimensional data107', 'Open source tools for visualizing multi-dimensional data?108', 109, 110, 111, 112, 113, 'Open source tools for visualizing multi-dimensional data?114');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (65, 51, 52, NULL, 54, 'Open source tools for visualizing multi-dimensional data55', 'Open source tools for visualizing multi-dimensional data?56', 'Open source tools for visualizing multi-dimensional data57', 58, 59, 60, 61, 62, 'Open source tools for visualizing multi-dimensional data63');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (45, 89, 65, 102, '1000-04-13', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Title = 'Open source tools for visualizing multi-dimensional data?';

/*
Gold Result:
*/

-- Prediction Query
SELECT u.DisplayName FROM posts AS p JOIN users AS u ON p.LastEditorUserId = u.Id WHERE p.Title = 'Open source tools for visualizing multi-dimensional data';

/*
Prediction Result:
('Open source tools for visualizing multi-dimensional data115',)
('Open source tools for visualizing multi-dimensional data115',)
*/