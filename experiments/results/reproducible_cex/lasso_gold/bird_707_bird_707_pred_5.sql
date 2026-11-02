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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3438, 3442, '1993-08-16', 'James Rodriguez', '1997-01-20', 'https://www.schneider.info/', '9032 Gerald Causeway
Loriville, NH 80615', 'admit', 3446, 3450, 3454, 3458, 3462, 'http://www.howe.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3439, 3447.0, '1993-08-17', 'Katelyn Mcclure', '1997-01-21', 'http://www.brown-french.com/', '17993 Linda Meadow
Lisafurt, MD 16334', 'until', 3465.0, 3471.0, 3477.0, 3483.0, 3489.0, 'https://aguirre.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3440, 3452.0, '1993-08-18', 'Collin Johnson', '1997-01-22', 'https://www.roman.net/', 'Unit 9825 Box 3092
DPO AA 08787', 'message', 3484.0, 3492.0, 3500.0, 3508.0, 3516.0, 'http://cole.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3441, 3457.0, '1993-08-19', 'Zachary Allen', '1997-01-23', 'https://www.riley.com/', '2582 Sanchez Prairie
East Craigfurt, WI 21178', 'be', 3503.0, 3513.0, 3523.0, 3533.0, 3543.0, 'http://clements.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3510, 3514, '1996-07-02', 'Amy Graham', '1971-11-06', 'http://www.taylor-york.info/', '392 Robert Cape Apt. 780
Schmidtfort, AS 91812', 'himself', 3518, 3522, 3526, 3530, 3534, 'http://www.allen-wilson.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3511, 3519.0, '1996-07-03', 'Leon Thompson', '1971-11-07', 'https://www.robinson-phillips.com/', '3180 Dodson Curve Suite 431
South Elizabethburgh, VT 60700', 'view', 3537.0, 3543.0, 3549.0, 3555.0, 3561.0, 'http://www.gomez-adams.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3512, 3524.0, '1996-07-04', 'Jimmy Lee', '1971-11-08', 'http://www.jenkins.info/', '7262 Sims Squares
Port Courtneyfurt, MH 91039', 'bring', 3556.0, 3564.0, 3572.0, 3580.0, 3588.0, 'https://www.watson.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3513, 3529.0, '1996-07-05', 'Derrick Rogers', '1971-11-09', 'http://ramirez-blair.com/', '6498 Kristin Common
Jillton, NY 88929', 'identify', 3575.0, 3585.0, 3595.0, 3605.0, 3615.0, 'http://patel.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3482, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3466, 3470, 3474, '1972-05-01', 3478, 125, 'kid', 3482, '1976-09-05', 'Engineer, agricultural', 'present', 3486, 3490, 3494, 3438, '1980-02-09', '1984-06-13', 3498, '1988-10-17', 'Julie Sims', 'Daniel King');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3467, 3475.0, 3481.0, '1972-05-02', 3489.0, 126, 'above', 3482, '1976-09-06', 'Commercial/residential surveyor', 'high', 3511.0, 3517.0, 3523.0, 3438, '1980-02-10', '1984-06-14', 3535.0, '1988-10-18', 'Anthony Rodriguez', 'Stefanie Chavez');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3468, 3480.0, 3488.0, '1972-05-03', 3500.0, 127, 'open', 3482, '1976-09-07', 'Senior tax professional/tax inspector', 'sort', 3536.0, 3544.0, 3552.0, 3438, '1980-02-11', '1984-06-15', 3572.0, '1988-10-19', 'Ryan Pruitt', 'Anthony Medina');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3469, 3485.0, 3495.0, '1972-05-04', 3511.0, 128, 'eat', 3482, '1976-09-08', 'Chief of Staff', 'notice', 3561.0, 3571.0, 3581.0, 3438, '1980-02-12', '1984-06-16', 3609.0, '1988-10-20', 'Christopher Livingston Jr.', 'Allen Robertson');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3538, 3542, 3546, '1975-04-10', 3550, 125, 'pressure', 3554, '1979-08-14', 'Brewing technologist', 'include', 3558, 3562, 3566, 3510, '1983-01-18', '1987-05-22', 3570, '1991-09-03', 'Donald Terry', 'Dorothy Brown');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3539, 3547.0, 3553.0, '1975-04-11', 3561.0, 126, 'hold', 3554, '1979-08-15', 'Emergency planning/management officer', 'water', 3583.0, 3589.0, 3595.0, 3510, '1983-01-19', '1987-05-23', 3607.0, '1991-09-04', 'Shaun Meyer DDS', 'Crystal Meza');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3540, 3552.0, 3560.0, '1975-04-12', 3572.0, 127, 'report', 3554, '1979-08-16', 'Programmer, systems', 'fight', 3608.0, 3616.0, 3624.0, 3510, '1983-01-20', '1987-05-24', 3644.0, '1991-09-05', 'Wayne Weaver', 'Jennifer Cooper');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3541, 3557.0, 3567.0, '1975-04-13', 3583.0, 128, 'young', 3554, '1979-08-17', 'Chartered loss adjuster', 'ball', 3633.0, 3643.0, 3653.0, 3510, '1983-01-21', '1987-05-25', 3681.0, '1991-09-06', 'Gregory Wallace', 'Erin Watkins');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3503, 3466, 3599.0, 'next', '1992-03-21', 3438, 'Elizabeth Mccormick');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3504, 3466, 3513.0, 'easy', '1992-03-22', 3438, 'Crystal Rodriguez');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3505, 3466, 3520.0, 'set', '1992-03-23', 3438, 'David Gutierrez');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3574, 3466, 3527.0, 'person', '1992-03-24', 3438, 'Steven Jones');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3502, 3538, 3599.0, 'want', '1995-02-07', 3510, 'Jennifer Burgess');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3575, 3538, 3585.0, 'thousand', '1995-02-08', 3510, 'Jacob Roberts');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3576, 3538, 3592.0, 'fly', '1995-02-09', 3510, 'Brittany Mitchell');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3577, 3538, 3506, 'cause', '1995-02-10', 3510, 'Lisa Martin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Text FROM comments WHERE PostId IN (SELECT Id FROM posts WHERE ViewCount BETWEEN 100 AND 150) ORDER BY Score DESC, comments.id NULLS LAST LIMIT 1;

/*
Gold Result:
('want',)
*/

-- Prediction Query
SELECT c.Text FROM posts AS p INNER JOIN comments AS c ON p.Id = c.PostId WHERE p.ViewCount BETWEEN 100 AND 150 ORDER BY c.Score DESC, p.id NULLS LAST, c.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('next',)
*/