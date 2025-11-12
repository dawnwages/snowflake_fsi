-- Scripts to create network rules and external access integration in Snowflake SQL worksheet from FSI Demo
-- FSI_WAREHOUSE was created in snowflake_fsi.ipynb demo.

-- Show the current network rules
SHOW NETWORK RULES;

-- Create network rule called `FSI_RULE`
CREATE OR REPLACE NETWORK RULE FSI_RULE
   TYPE = HOST_PORT
   MODE = EGRESS

-- Create access integration for our census data
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION FSI_CENSUS
   ALLOWED_NETWORK_RULES = FSI_RULE
   ENABLED = TRUE

-- Create a secret that will require password called `FSI_SECRET`
CREATE OR REPLACE SECRET FSI_SECRET
   TYPE = GENERIC_STRING
   SECRET_STRING = 'password'

-- Create external access integration named `FSI_ACCESS`
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION FSI_ACCESS
    ALLOWED_NETWORK_RULES = (FSI_RULE)
    ALLOWED_AUTHENTICATION_SECRETS = (FSI_SECRET)
    ENABLED = true;

-- Resume warehouse called `FSI_WAREHOUSE`
ALTER WAREHOUSE FSI_WAREHOUSE RESUME;