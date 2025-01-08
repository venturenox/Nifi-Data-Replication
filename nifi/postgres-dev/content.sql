CREATE extension dblink;

-- --- Content Database
INSERT INTO "TenantProfile" ("tenant_id", "tenant_name", "address", "zip_code", "state", "country","phone", "web_url", "image_url")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT tenant_id, tenant_name, address, zip_code, state, country, phone, web_url, image_url from 
"TenantProfile"') as data(tenant_id int, tenant_name varchar, address varchar, zip_code varchar, state varchar, country varchar, phone varchar, web_url varchar, image_url varchar) ON CONFLICT ON CONSTRAINT "TenantProfile_pkey" DO UPDATE SET tenant_id = excluded.tenant_id, tenant_name = excluded.tenant_name, address = excluded.address, zip_code = excluded.zip_code, state = excluded.state, country = excluded.country, phone = excluded.phone, web_url = excluded.web_url, image_url = excluded.image_url;

INSERT INTO "UserProfile" ("user_id", "first_name", "last_name", "tenant_id","image_url","address","contact_no","employee_id","is_archive","city","country","gender","dob","department_id","designation_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT user_id, first_name, last_name, tenant_id, image_url, address, contact_no, employee_id, is_archive, city, country, gender, dob, department_id, designation_id  from 
"UserProfile"') as data(user_id int, first_name varchar, last_name varchar, tenant_id int,image_url varchar,address varchar,contact_no varchar,employee_id int,is_archive boolean,city varchar,country varchar,gender varchar,dob date,department_id int,designation_id int) ON CONFLICT ON CONSTRAINT "UserProfile_pkey" DO UPDATE SET user_id = excluded.user_id, first_name = excluded.first_name, last_name = excluded.last_name, tenant_id = excluded.tenant_id, image_url = excluded.image_url, address = excluded.address, contact_no = excluded.contact_no, employee_id = excluded.employee_id, is_archive = excluded.is_archive, city = excluded.city, country = excluded.country, gender = excluded.gender, dob = excluded.dob, department_id = excluded.department_id, designation_id = excluded.designation_id;

INSERT INTO "Cohort" ("id", "tenant_id", "name", "logic","users","description","filters")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT id, tenant_id, name, logic, users, description, filters from 
"Cohort"') as data(id int, tenant_id int, name varchar, logic varchar, users int, description varchar, filters json) ON CONFLICT ON CONSTRAINT "Cohort_pkey" DO UPDATE SET id = excluded.id, tenant_id = excluded.tenant_id, name = excluded.name, logic = excluded.logic, users = excluded.users, description = excluded.description, filters = excluded.filters;

INSERT INTO "CohortMapping" ("id", "cohort_id", "user_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT id, cohort_id, user_id from 
"CohortMapping"') as data(id int, cohort_id int, user_id int) ON CONFLICT ON CONSTRAINT "CohortMapping_pkey" DO UPDATE SET id = excluded.id, cohort_id = excluded.cohort_id, user_id = excluded.user_id;

INSERT INTO "Departments" ("id", "name")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT id, name from 
"Departments"') as data(id int, name varchar) ON CONFLICT ON CONSTRAINT "Departments_pkey" DO UPDATE SET id = excluded.id, name = excluded.name;

INSERT INTO "Designations" ("id", "name")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT id, name from 
"Designations"') as data(id int, name varchar) ON CONFLICT ON CONSTRAINT "Designations_pkey" DO UPDATE SET id = excluded.id, name = excluded.name;

INSERT INTO "DetectedUsers" ("id", "identifier", "identifier_id", "username", "is_mapped", "tenant_id","integration_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "identifier", "identifier_id", "username", "is_mapped", "tenant_id","integration_id" from 
"DetectedUsers"') as data(id int, identifier varchar,identifier_id varchar,username varchar, is_mapped boolean, tenant_id int,integration_id int  ) ON CONFLICT ON CONSTRAINT "DetectedUsers_pkey" DO UPDATE SET id = excluded.id, identifier = excluded.identifier, identifier_id = excluded.identifier_id, username = excluded.username, is_mapped = excluded.is_mapped, tenant_id = excluded.tenant_id, integration_id = excluded.integration_id;

INSERT INTO "EventMapping" ("id", "event_name", "integration_id", "event_type")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "event_name", "integration_id", "event_type" from 
"EventMapping"') as data(id int, event_name varchar,integration_id int,event_type varchar) ON CONFLICT ON CONSTRAINT "EventMapping_pkey" DO UPDATE SET id = excluded.id, event_name = excluded.event_name, integration_id = excluded.integration_id, event_type = excluded.event_type;

INSERT INTO "Group" ("id", "tenant_id", "name", "email","identifier","identifier_id","member_count","sync_type")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "tenant_id", "name", "email","identifier","identifier_id","member_count","sync_type" from 
"Group"') as data(id int, tenant_id int,name text,email varchar, identifier varchar,identifier_id varchar,member_count varchar,sync_type varchar) ON CONFLICT ON CONSTRAINT "Group_pkey" DO UPDATE SET id = excluded.id, tenant_id = excluded.tenant_id, name = excluded.name, email = excluded.email,identifier = excluded.identifier, identifier_id = excluded.identifier_id, member_count = excluded.member_count, sync_type = excluded.sync_type;


INSERT INTO "Team" ("id", "name", "description", "image_url","tenant_id","group_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "name", "description","image_url","tenant_id","group_id" from 
"Team"') as data(id int, name text,description text, image_url varchar,tenant_id int,group_id int) ON CONFLICT ON CONSTRAINT "Team_pkey" DO UPDATE SET id = excluded.id, name = excluded.name, description = excluded.description ,image_url = excluded.image_url, tenant_id = excluded.tenant_id, group_id = excluded.group_id;


INSERT INTO "GroupMembers" ("id", "user_id", "group_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "user_id", "group_id" from 
"GroupMembers"') as data(id int, user_id int,group_id int) ON CONFLICT ON CONSTRAINT "GroupMembers_pkey" DO UPDATE SET id = excluded.id, user_id = excluded.user_id, group_id = excluded.group_id;

INSERT INTO "Identifier" ("id", "user_id", "type","identifier","identifier_id","email","is_primary")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "user_id", "type","identifier","identifier_id","email","is_primary" from 
"Identifier"') as data(id int, user_id int,type varchar, identifier varchar,identifier_id varchar,email varchar, is_primary boolean  ) ON CONFLICT ON CONSTRAINT "Identifier_pkey" DO UPDATE SET id = excluded.id, user_id = excluded.user_id, type = excluded.type, identifier = excluded.identifier, identifier_id = excluded.identifier_id, email = excluded.email, is_primary = excluded.is_primary;

INSERT INTO "Integration" ("id", "name", "image_url","type","category")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "name", "image_url","type","category" from 
"Integration"') as data(id int, name text,image_url varchar, type varchar,category varchar) ON CONFLICT ON CONSTRAINT "Integration_pkey" DO UPDATE SET id = excluded.id, name = excluded.name, image_url = excluded.image_url, type = excluded.type, category = excluded.category;

INSERT INTO "TenantIntegration" ("id", "tenant_id","integration_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=content', 'SELECT "id", "tenant_id","integration_id" from 
"TenantIntegration"') as data(id int, tenant_id int,integration_id int) ON CONFLICT ON CONSTRAINT "TenantIntegration_pkey" DO UPDATE SET id = excluded.id, tenant_id = excluded.tenant_id, integration_id = excluded.integration_id;