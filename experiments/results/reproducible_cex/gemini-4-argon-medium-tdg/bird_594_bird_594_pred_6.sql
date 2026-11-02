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
-- Tests basic join, PostId boundary conditions (0, 1, 2, NULL), NULL UserId (INNER vs LEFT JOIN), and incorrect join condition mutants (e.g., T1.Id = T2.Id, T1.PostId = T2.Id).
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (1, 111, 10, 5, 1, 1001, 25);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (2, 222, 20, 6, 2, 1002, 30);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (10, 500, 30, 7, 3, 1010, 35);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (20, 600, 40, 8, 4, 1020, 40);
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId) VALUES (0, 1, 5, 1);
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId) VALUES (1, 1, 10, 1);
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId) VALUES (2, 2, 15, 2);
INSERT INTO comments (Id, PostId, Score, Text, UserId) VALUES (100, 1, 99, 'Valid comment on post 1', 10);
INSERT INTO comments (Id, PostId, Score, Text, UserId) VALUES (101, 1, 88, 'Anonymous comment on post 1', NULL);
INSERT INTO comments (Id, PostId, Score, Text, UserId) VALUES (1, 2, 77, 'Comment with Id=1 on post 2', 20);
INSERT INTO comments (Id, PostId, Score, Text, UserId) VALUES (102, 0, 66, 'Comment on post 0', 10);
INSERT INTO comments (Id, PostId, Score, Text, UserId) VALUES (103, NULL, 55, 'Comment with NULL PostId', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Id, T2.Reputation FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.PostId = 1;

/*
Gold Result:
(10, 500)
*/

-- Prediction Query
SELECT T2.DisplayName, T2.Reputation FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Id = 1;

/*
Prediction Result:
(None, 111)
*/