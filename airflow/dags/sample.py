from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def helloworld():
    print("Hello, World!")

with DAG(dag_id="first_dag_dbt_snowflake",
        start_date=datetime(2025,7,31),
        schedule='@hourly',
        catchup=False,
) as dag:
    task = PythonOperator(
        task_id='HelloWorld',
        python_callable=helloworld
    )

task
