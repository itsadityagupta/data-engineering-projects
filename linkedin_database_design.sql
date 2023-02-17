CREATE TYPE Visibility AS ENUM ('PUBLIC', 'PRIVATE', 'CONNECTIONS_ONLY');
CREATE TYPE EmploymentType AS ENUM ('FULL-TIME', 'PART-TIME', 'SELF-EMPLOYED', 'FREELANCE', 'INTERNSHIP', 'TRAINEE');
CREATE TYPE LocationType AS ENUM ('ON-SITE', 'HYBRID', 'REMOTE');
CREATE TYPE Reaction AS ENUM ('LIKE', 'CELEBRATE', 'SUPPORT', 'FUNNY', 'LOVE', 'INSIGHTFUL');
CREATE TYPE ConnectionStatus AS ENUM ('CONNECTED', 'PENDING', 'BLOCKED');

DROP TABLE IF EXISTS ContactInformation;
CREATE TABLE ContactInformation(
	contact_information_id varchar(15),

	email varchar(50) NOT NULL UNIQUE,
	email_visibility Visibility DEFAULT 'PUBLIC',

	phone_no varchar(15) UNIQUE,
	phone_no_visibility Visibility DEFAULT 'PUBLIC',

	website varchar(200) UNIQUE,
	website_visibility Visibility DEFAULT 'PUBLIC',

	PRIMARY KEY (contact_information_id)
);

DROP TABLE IF EXISTS Companies;
CREATE TABLE Companies (
	company_id varchar(15),

	company_name varchar(100) NOT NULL,
	company_website varchar(100) NOT NULL,
	about_company varchar(2600),

	PRIMARY KEY (company_id)
);

DROP TABLE IF EXISTS Experiences;
CREATE TABLE Experiences (
	experience_id varchar(15),

	company_id varchar(15) NOT NULL,
	profile_headline varchar(100) NOT NULL,
	employment_type EmploymentType NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	location_type LocationType,
	employment_location varchar(100),
	is_current_role bool NOT NULL,
	employment_industry varchar(100) NOT NULL,
	description varchar(2000),

	PRIMARY KEY (experience_id),
	FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

DROP TABLE IF EXISTS Schools;
CREATE TABLE Schools (
	school_id varchar(15),

	school_name varchar(100) NOT NULL,
	location varchar(100) NOT NULL,
	website varchar(100),

	PRIMARY KEY (school_id)
);

DROP TABLE IF EXISTS EducationDetails;
CREATE TABLE EducationDetails (
	education_id varchar(15),

	school_id varchar(15) NOT NULL,
	degree varchar(100) NOT NULL,
	field_of_study varchar(200),
	start_date date NOT NULL,
	end_date date NOT NULL,
	grade varchar(20),
	description varchar(1000),

	PRIMARY KEY (education_id),
	FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

DROP TABLE IF EXISTS Skills;
CREATE TABLE Skills (
	skill_id varchar(15),

	skill_name varchar(50),

	PRIMARY KEY (skill_id)
);

DROP TABLE IF EXISTS ExperienceSkills;
CREATE TABLE ExperienceSkills (
	experience_id varchar(15) NOT NULL,
	skill_id varchar(15) NOT NULL,

	PRIMARY KEY (experience_id, skill_id),
	FOREIGN KEY (experience_id) REFERENCES Experiences(experience_id),
	FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

DROP TABLE IF EXISTS EducationSkills;
CREATE TABLE EducationSkills (
	education_id varchar(15) NOT NULL,
	skill_id varchar(15) NOT NULL,

	PRIMARY KEY (education_id, skill_id),
	FOREIGN KEY (education_id) REFERENCES EducationDetails(education_id),
	FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

DROP TABLE IF EXISTS UserProfiles;
CREATE TABLE UserProfiles (
	user_id varchar(15),

	first_name varchar(50) NOT NULL,
	middle_name varchar(50),
	last_name varchar(50) NOT NULL,

	contact_information_id varchar(15) NOT NULL,

	headline varchar(220) NOT NULL,
	location varchar(100),
	about_section varchar(2600),

	PRIMARY KEY (user_id),
	FOREIGN KEY (contact_information_id) REFERENCES ContactInformation(contact_information_id)
);

DROP TABLE IF EXISTS UserExperience;
CREATE TABLE UserExperience (
	user_id varchar(15),
	experience_id varchar(15),

	PRIMARY KEY (user_id, experience_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id),
	FOREIGN KEY (experience_id) REFERENCES Experiences(experience_id)
);

DROP TABLE IF EXISTS UserEducationDetails;
CREATE TABLE UserEducationDetails (
	user_id varchar(15),
	education_id varchar(15),

	PRIMARY KEY (user_id, education_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id),
	FOREIGN KEY (education_id) REFERENCES EducationDetails(education_id)
);

DROP TABLE IF EXISTS UserSkills;
CREATE TABLE UserSkills (
	user_id varchar(15),
	skill_id varchar(15),

	PRIMARY KEY (user_id, skill_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id),
	FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

DROP TABLE IF EXISTS Posts;
CREATE TABLE Posts (
	post_id varchar(15),

	user_id varchar(15) NOT NULL,
	description varchar(3000) NOT NULL,

	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,

	PRIMARY KEY (post_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id)
);

DROP TABLE IF EXISTS PostReactions;
CREATE TABLE PostReactions (
	post_id varchar(15),
	user_id varchar(15),

	reaction Reaction NOT NULL,

	PRIMARY KEY (post_id, user_id),
	FOREIGN KEY (post_id) REFERENCES Posts(post_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id)
);

DROP TABLE IF EXISTS Comments;
CREATE TABLE Comments (
	comments_id varchar(15),

	post_id varchar(15) NOT NULL,
	user_id varchar(15) NOT NULL,
	description varchar(2000),

	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,

	PRIMARY KEY (comments_id),
	FOREIGN KEY (post_id) REFERENCES Posts(post_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id)
);

DROP TABLE IF EXISTS CommentReactions;
CREATE TABLE CommentReactions (
	comments_id varchar(15),
	user_id varchar(15),

	reaction Reaction NOT NULL,

	PRIMARY KEY (comments_id, user_id),
	FOREIGN KEY (comments_id) REFERENCES Comments(comments_id),
	FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id)
);

DROP TABLE IF EXISTS Connections;
CREATE TABLE Connections (
	connection_id varchar(15),

	request_sent_by varchar(15) NOT NULL,
	request_sent_to varchar(15) NOT NULL,
	request_status ConnectionStatus NOT NULL,

	PRIMARY KEY (connection_id),
	FOREIGN KEY (request_sent_by) REFERENCES UserProfiles(user_id),
	FOREIGN KEY (request_sent_to) REFERENCES UserProfiles(user_id)
);

DROP TABLE IF EXISTS Followers;
CREATE TABLE Followers (
	followed_by varchar(15),
	following varchar(15),

	PRIMARY KEY (following, followed_by),
	FOREIGN KEY (followed_by) REFERENCES UserProfiles(user_id),
	FOREIGN KEY (following) REFERENCES UserProfiles(user_id)
);
