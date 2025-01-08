CREATE extension dblink;

-- --- Notification Database
INSERT INTO "TenantProfile" ("tenant_id", "tenant_name", "address", "zip_code", "state", "country", "phone", "web_url", "image_url")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT tenant_id, tenant_name, address, zip_code, state, country, phone, web_url, image_url from 
"TenantProfile"') as data(tenant_id int, tenant_name varchar, address json, zip_code varchar, state varchar, country varchar, phone varchar, web_url varchar, image_url varchar) ON CONFLICT ON CONSTRAINT "TenantProfile_pkey" DO UPDATE SET tenant_id = excluded.tenant_id, tenant_name = excluded.tenant_name, address = excluded.address, zip_code = excluded.zip_code, state = excluded.state, country = excluded.country, phone = excluded.phone, web_url = excluded.web_url, image_url = excluded.image_url;

INSERT INTO "UserProfile" ("user_id", "first_name", "last_name", "department_id", "designation_id", "tenant_id", "image_url", "address", "is_archive", "city", "country", "gender", "dob", "contact_no", "employee_id", "manager_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT user_id, first_name, last_name, department_id, designation_id, tenant_id, image_url, address, is_archive, city, country, gender, dob, "contact_no", "employee_id", "manager_id" from 
"UserProfile"') as data(user_id int, first_name varchar, last_name varchar, department_id int,designation_id int,tenant_id int,image_url varchar,address varchar,is_archive boolean,city varchar,country varchar,gender varchar,dob date,contact_no varchar,employee_id int, manager_id int) ON CONFLICT ON CONSTRAINT "UserProfile_pkey" DO UPDATE SET user_id = excluded.user_id, first_name = excluded.first_name, last_name = excluded.last_name, department_id = excluded.department_id, designation_id = excluded.designation_id, tenant_id = excluded.tenant_id, image_url = excluded.image_url, address = excluded.address, is_archive = excluded.is_archive, city = excluded.city, country = excluded.country, gender = excluded.gender, dob = excluded.dob, contact_no = excluded.contact_no, employee_id = excluded.employee_id, manager_id = excluded.manager_id;

INSERT INTO "TenantClient" ("client_id", "name","logo","tenant_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT client_id, name, logo, tenant_id from 
"TenantClient"') as data(client_id int, name varchar, logo varchar, tenant_id int) ON CONFLICT ON CONSTRAINT "TenantClient_pkey" DO UPDATE SET client_id = excluded.client_id, name = excluded.name, logo = excluded.logo, tenant_id = excluded.tenant_id;

INSERT INTO "Identifier" ("id", "user_id","type","identifier", "identifier_id","email","is_primary")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT id, user_id,type,identifier, identifier_id,email,is_primary from 
"Identifier"') as data(id int, user_id int,type varchar,identifier varchar, identifier_id varchar,email varchar,is_primary boolean) ON CONFLICT ON CONSTRAINT "Identifier_pkey" DO UPDATE SET id = excluded.id, user_id = excluded.user_id, type = excluded.type, identifier = excluded.identifier, identifier_id = excluded.identifier_id, email =excluded.email,is_primary = excluded.is_primary;

INSERT INTO "Event" ("event_id", "event_name")
SELECT *
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT event_id, event_name from 
"Event"') as data(event_id int, event_name varchar) ON CONFLICT ON CONSTRAINT "Event_pkey" DO UPDATE SET event_id = excluded.event_id, event_name = excluded.event_name;

INSERT INTO "Method" ("method_id", "method_name")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT method_id, method_name from 
"Method"') as data(method_id int, method_name varchar) ON CONFLICT ON CONSTRAINT "Method_pkey" DO UPDATE SET method_id = excluded.method_id, method_name = excluded.method_name;

INSERT INTO "Subscription" ("subscription_id", "event_id","method_id","user_id","tenant_id","client_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=pr261-notification', 'SELECT subscription_id, event_id, method_id, user_id, tenant_id, client_id from 
"Subscription"') as data(subscription_id int, event_id int,method_id int,user_id int,tenant_id int,client_id int) ON CONFLICT ON CONSTRAINT "Subscription_pkey" DO UPDATE SET subscription_id = excluded.subscription_id, event_id = excluded.event_id, method_id=excluded.method_id, user_id=excluded.user_id,tenant_id=excluded.tenant_id,client_id=excluded.client_id;


