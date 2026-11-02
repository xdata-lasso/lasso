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
-- Tests basic join, WHERE clause filtering, wrong join keys (e.g., LastEditorUserId, T1.Id=T2.Id), and OwnerDisplayName vs users.DisplayName confusion.
INSERT INTO users (Id, DisplayName, Reputation, AccountId) VALUES (10, 'Vebjorn Ljosa', 100, 1000);
INSERT INTO users (Id, DisplayName, Reputation, AccountId) VALUES (20, 'Other User', 200, 2000);
INSERT INTO users (Id, DisplayName, Reputation, AccountId) VALUES (30, 'Vebjorn Ljosa Clone', 300, 3000);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName, PostTypeId, Score) VALUES (1, 10, 20, 'Correct Title', 'Post Body', 'Wrong Owner Name', 'Other User', 1, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName, PostTypeId, Score) VALUES (2, 20, 10, 'Edited By Vebjorn Only', 'Body 2', 'Vebjorn Ljosa', 'Vebjorn Ljosa', 1, 10);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName, PostTypeId, Score) VALUES (10, 20, 20, 'ID Matches User ID', 'Body 3', 'Other User', 'Other User', 1, 15);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName, PostTypeId, Score) VALUES (3, NULL, 10, 'Orphan Post With Matching OwnerDisplayName', 'Body 4', 'Vebjorn Ljosa', 'Vebjorn Ljosa', 1, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Vebjorn Ljosa';

/*
Gold Result:
('Correct Title',)
*/

-- Prediction Query
SELECT posts.Title FROM posts INNER JOIN users ON posts.LastEditorUserId = users.Id WHERE users.DisplayName = 'Vebjorn Ljosa';

/*
Prediction Result:
('Edited By Vebjorn Only',)
('Orphan Post With Matching OwnerDisplayName',)
*/