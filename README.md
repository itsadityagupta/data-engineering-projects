# LinkedIn Database Design

![](linkedindbheader.png)

LinkedIn stands out as a professional networking platform with a user base of over 750 million professionals worldwide. 
It handles an enormous amount of user data, including profiles, connections, job postings, and much more. In this blog post, 
I'll design a database for LinkedIn and understand the various entities and relationships between them.

To keep the scope of this blog limited, here are the requirements that we want our database to satisfy:

1. Users can create their profile with information like name, contact information, headline, summary, education, work experience and different skills.
2. Users can send connection requests to other users, or follow them only. They should also be able to accept or reject the connection request.
3. Users can create posts, and like and comment on others' 

> Find the SQL code for the design in the file [linkedin_database_design.sql](https://github.com/Aditya-Gupta1/data-engineering-projects/blob/linkedin-db-design-oltp/linkedin_database_design.sql) and read the entire blog post [here](https://itsadityagupta.hashnode.dev/linkedin-database-design). 

### Complete Database Design

![](linkedindatabasedesign.png)