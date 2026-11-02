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
-- DATASET 1
INSERT INTO users (Id, DisplayName) VALUES (1, 'User1');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ParentId, AcceptedAnswerId, Body, Title)
VALUES (10, 1, 1, 10, 10, 'Why square the difference instead of taking the absolute value in standard deviation?', 'Other Title');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ParentId, AcceptedAnswerId, Body, Title)
VALUES (20, 1, 1, 10, 10, 'Normal body', 'Why square the difference instead of taking the absolute value in standard deviation?');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ParentId, AcceptedAnswerId, Body, Title)
VALUES (30, 1, 1, 10, 10, 'Normal body', NULL);
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment)
VALUES (20, 10, 1, 20, 'Text20', 'WrongJoinComment');
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment)
VALUES (100, 20, 1, 1, 'Text100', 'TargetComment');
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment)
VALUES (101, 20, 1, 2, 'Text101', 'TargetComment');
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment)
VALUES (102, 20, 1, 3, 'Text102', NULL);
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment)
VALUES (103, NULL, 1, 4, 'Text103', 'OrphanHistoryComment');
INSERT INTO comments (Id, PostId, UserId, Text)
VALUES (1, 20, 1, 'WrongTableComment');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Comment FROM posts AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.PostId WHERE T1.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Gold Result:
('TargetComment',)
('TargetComment',)
(None,)
*/

-- Prediction Query
SELECT "comments"."text" FROM "comments" INNER JOIN "posthistory" ON "comments"."postid" = "posthistory"."postid" INNER JOIN "posts" ON "posthistory"."postid" = "posts"."id" WHERE "posts"."title" = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Prediction Result:
('WrongTableComment',)
('WrongTableComment',)
('WrongTableComment',)
*/