## Data Pipeline

- This data pipeline integerates connection to dbt and snowflake
- Staging models are created in `models/staging` from `tpch` source hosted in snowflake database
- Then a macros is created in `macros/pricing.sql` for calculating `discounted_amount`

  ```sql
  {% macro discounted_amount(extended_price, discount_percentage, scale=2) %}
      (-1 * {{extended_price}} * {{discount_percentage}})::decimal(16, {{ scale }})
  {% endmacro %}
  ```

- Transfromation models are stored in `models/marts`
- Then singular and generic tests are written in `tests` to check if each `discounted_amount` is positive
- Another test is if the date for `order_date` is less than current date and higher than `1990-01-01`

### Deploy on Airflow

- Update dockerfile with

  ```bash
  RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
      pip install --no-cache-dir dbt-snowflake && deactivate
  ```

- Run astro cosmos to spin up docker containers and visualize dags in airflow
- Snowflake view gets populated and can be queried through worksheets

- <div align="left">
    <img 
        src="https://github.com/user-attachments/assets/ecc44ba2-11d1-4ea8-9521-6d8474fcb70a" 
        alt="image" 
        style="border-radius: 8px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); max-width: 80%; margin: 20px 0;"
    >
    </div>
