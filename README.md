- Sales Assignment - DBT Project

  This project is designed to demonstrate data transformations, tests, and documentation using `dbt` (Data Build Tool) with Snowflake as the data warehouse. The project transforms data from source tables in Snowflake, applying various data quality checks along the way.

- Project Structure

  - models/: Contains the dbt models (SQL files) with data transformation logic.
  - models/sources.yml: Defines source tables from Snowflake, including data quality tests on specific columns.
  - models/schema.yml: Specifies tests and descriptions for the transformed models.
  - dbt_project.yml: Main configuration file for the `dbt` project.

- Requirements

  - dbt (Data Build Tool)
  - Python (for dbt installation)
  - Snowflake account with necessary credentials

- Setting Up the Environment

  1. Install dbt:
     - Follow the installation instructions for `dbt` for Windows. Once installed, verify the installation by running:
      
       dbt --version

  2. Set Up Environment Variables:
     - This project uses environment variables to store sensitive credentials. To set these up on Windows:
       - Open Command Prompt or PowerShell and set each environment variable as follows:

         $env:DBT_SNOWFLAKE_ACCOUNT="your_account_id"
         $env:DBT_SNOWFLAKE_USER="your_username"
         $env:DBT_SNOWFLAKE_PASSWORD="your_password"
         $env:DBT_SNOWFLAKE_ROLE="your_role"
         $env:DBT_SNOWFLAKE_DATABASE="your_database"
         $env:DBT_SNOWFLAKE_WAREHOUSE="your_warehouse"
         $env:DBT_SNOWFLAKE_SCHEMA="your_schema"

         Replace each placeholder with your actual Snowflake credentials and details.

  3. Set Up `profiles.yml`:
     
	 - dbt uses a profiles.yml file for connection settings.
	 Place this file in your `C:\Users\<YourUsername>\.dbt\` directory.
	 
     - Use the following configuration for `profiles.yml`:

       sales_assignment:
         outputs:
           dev:
             type: snowflake
             account: "{{ env_var('DBT_SNOWFLAKE_ACCOUNT') }}"
             user: "{{ env_var('DBT_SNOWFLAKE_USER') }}"
             password: "{{ env_var('DBT_SNOWFLAKE_PASSWORD') }}"
             role: "{{ env_var('DBT_SNOWFLAKE_ROLE') }}"
             database: "{{ env_var('DBT_SNOWFLAKE_DATABASE') }}"
             warehouse: "{{ env_var('DBT_SNOWFLAKE_WAREHOUSE') }}"
             schema: "{{ env_var('DBT_SNOWFLAKE_SCHEMA') }}"
             threads: 1
         target: dev

     - Ensure all required environment variables are set before running dbt commands.

- How to Build and Run the Project

  1. Install Dependencies (if any):
     - Run the following command to install dependencies:
       dbt deps

  2. Compile and Run Models:
     - This command will build all models in the project:
       dbt run

  3. Run Data Quality Tests:
     - Run tests defined in `schema.yml` and `sources.yml` to check data quality:
       dbt test

- Cleaning Up:

  To remove compiled models, tests, and temporary files, run:
  dbt clean

- Notes:

- Configuration: All configurations for this project are handled using `profiles.yml` and environment variables to keep sensitive data secure.

- Testing: Data integrity is enforced through dbt tests defined in schema.yml and sources.yml.