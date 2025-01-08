CREATE extension dblink;

--- Sternguard Database
INSERT INTO "Tenant" ("id", "tenant_domain","allow_users_signin" ,"created_at", "updated_at")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, tenant_domain, allow_users_signin, created_at, updated_at from 
"Tenant"') as data(id int, tenant_domain varchar,allow_users_signin	boolean, created_at date, updated_at date) ON CONFLICT ON CONSTRAINT "Tenant_pkey" DO UPDATE SET id = excluded.id, tenant_domain = excluded.tenant_domain,allow_users_signin = excluded.allow_users_signin, created_at = excluded.created_at, updated_at = excluded.updated_at;

INSERT INTO "User" ("id", "email", "password", "tenant_id", "is_active", "created_at", "updated_at")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, email, password, tenant_id, is_active, created_at, updated_at from 
"User"') as data(id int, email varchar, password varchar, tenant_id int, is_active boolean, created_at date, updated_at date) ON CONFLICT ON CONSTRAINT "User_pkey" DO UPDATE SET id = excluded.id, email = excluded.email, password = excluded.password, tenant_id = excluded.tenant_id, is_active = excluded.is_active, created_at = excluded.created_at, updated_at = excluded.updated_at;

INSERT INTO "Role" ("id", "name")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, name from 
"Role"') as data(id varchar, name varchar) ON CONFLICT ON CONSTRAINT "Role_pkey" DO UPDATE SET id = excluded.id, name = excluded.name;

INSERT INTO "UserRole" ("id", "user_id", "tenant_id","role_id", "created_at", "updated_at")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, user_id, tenant_id, role_id, created_at, updated_at from 
"UserRole"') as data(id int, user_id int, tenant_id int, role_id varchar, created_at date, updated_at date) ON CONFLICT ON CONSTRAINT "UserRole_pkey" DO UPDATE SET id = excluded.id, user_id = excluded.user_id, tenant_id = excluded.tenant_id, role_id = excluded.role_id, created_at = excluded.created_at, updated_at = excluded.updated_at;

INSERT INTO "Action" ("id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id from 
"Action"') as data(id varchar) ON CONFLICT ON CONSTRAINT "Action_pkey" DO UPDATE SET id = excluded.id;

INSERT INTO "Object" ("id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id from 
"Object"') as data(id varchar ) ON CONFLICT ON CONSTRAINT "Object_pkey" DO UPDATE SET id = excluded.id;

INSERT INTO "Permission" ("id", "object_id", "action_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, object_id, action_id from 
"Permission"') as data(id varchar, object_id varchar, action_id varchar) ON CONFLICT ON CONSTRAINT "Permission_pkey" DO UPDATE SET id = excluded.id, object_id = excluded.object_id, action_id = excluded.action_id;

INSERT INTO "PermissionAssignment" ("id", "permission_id", "role_id")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, permission_id, role_id from 
"PermissionAssignment"') as data(id int, permission_id varchar, role_id varchar) ON CONFLICT ON CONSTRAINT "permissionassignment_permission_id_role_id_unique" DO UPDATE SET id = excluded.id, permission_id = excluded.permission_id, role_id = excluded.role_id;

INSERT INTO "StripePricing" ("id", "stripe_product_id", "group_key","price_per_unit", "is_recurring", "interval","trial_period_days","is_active")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, stripe_product_id, group_key, price_per_unit, is_recurring, interval, trial_period_days, is_active from 
"StripePricing"') as data(id varchar, stripe_product_id varchar, group_key varchar,price_per_unit numeric, is_recurring boolean, interval varchar, trial_period_days int, is_active boolean) ON CONFLICT ON CONSTRAINT "StripePricing_pkey" DO UPDATE SET id = excluded.id, stripe_product_id = excluded.stripe_product_id, group_key = excluded.group_key, price_per_unit = excluded.price_per_unit, is_recurring = excluded.is_recurring, interval = excluded.interval, trial_period_days = excluded.trial_period_days, is_active = excluded.is_active;

INSERT INTO "StripeProduct" ("id", "name", "is_public","allowed_users", "allowed_integrations", "is_active","created_at","updated_at")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT id, name, is_public, allowed_users, allowed_integrations, is_active, created_at, updated_at from 
"StripeProduct"') as data(id varchar, name varchar, is_public boolean,allowed_users int, allowed_integrations int, is_active boolean, created_at date, updated_at date) ON CONFLICT ON CONSTRAINT "StripeProduct_pkey" DO UPDATE SET id = excluded.id, name = excluded.name, is_public = excluded.is_public, allowed_users = excluded.allowed_users, allowed_integrations = excluded.allowed_integrations, is_active = excluded.is_active,  created_at = excluded.created_at, updated_at = excluded.updated_at;

INSERT INTO "Subscription" ("id", "stripe_pricing_id", "tenant_id", "status", "stripe_customer_id", "stripe_subscription_id", "expires_at", "created_at","updated_at")
SELECT * 
FROM dblink('host= crewnetics-stag.csicmrww6n6h.us-east-1.rds.amazonaws.com user=postgres password=pCH3e1PwMI4B dbname=sternguard', 'SELECT "id", "stripe_pricing_id", "tenant_id", "status", "stripe_customer_id", "stripe_subscription_id", "expires_at", "created_at","updated_at" from 
"Subscription"') as data(id int, stripe_pricing_id varchar, tenant_id int, status varchar, stripe_customer_id varchar, stripe_subscription_id varchar, expires_at varchar, created_at date, updated_at date) ON CONFLICT ON CONSTRAINT "Subscription_pkey" DO NOTHING;

-- SELECT setval('"Action_id_seq"', (SELECT max(id) from "Action"));
-- SELECT setval('"Object_id_seq"', (SELECT max(id) from "Object"));
-- SELECT setval('"Permission_id_seq"', (SELECT max(id) from "Permission"));
-- SELECT setval('"Permission_Assignment_id_seq"', (SELECT max(id) from "Permission_Assignment"));
-- SELECT setval('"Role_id_seq"', (SELECT max(id) from "Role"));
-- SELECT setval('"Role_Scope_id_seq"', (SELECT max(id) from "Role_Scope"));
-- SELECT setval('"Subscription_id_seq"', (SELECT max(id) from "Subscription"));
-- SELECT setval('"Tenant_id_seq"', (SELECT max(id) from "Tenant"));
-- SELECT setval('"User_id_seq"', (SELECT max(id) from "User"));
-- SELECT setval('"User_Role_id_seq"', (SELECT max(id) from "User_Role"));



-- INSERT INTO "StripePricing" ("id", "stripe_product_id", "group_key", "price_per_unit", "is_recurring", "interval", "trial_period_days", "allowed_users", "payment_threshold", "alert_threshold", "is_active") VALUES
-- ('price_1LO0qFJ7pxvODI5pldhz5YLf',	'prod_M1H3ZrQFthmaLE',	'prod_M1H3ZrQFthmaLE',	199.00,	'1',	'month',	0,	0,	0,	0,	'1'),
-- ('price_1LJEV6J7pxvODI5pEyCmKR8x',	'prod_M1H3ZrQFthmaLE',	'batch_1',	199.00,	'1',	'month',	0,	0,	0,	0,	'0') ON CONFLICT ON CONSTRAINT "StripePricing_pkey" DO NOTHING;

-- INSERT INTO "StripeProduct" ("id", "name", "is_public", "is_active", "created_at", "updated_at") VALUES
-- ('prod_M1H3ZrQFthmaLE',	'Base',	'1',	'1',	'2022-07-08 16:03:21.869206+00',	'2022-07-21 17:19:56.921+00') ON CONFLICT ON CONSTRAINT "StripeProduct_pkey" DO NOTHING


