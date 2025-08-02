from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime
from airflow.operators.empty import EmptyOperator
from airflow.utils.task_group import TaskGroup

PROJECT_DIR = '/mnt/c/Users/sanja/OneDrive/Documents/sanjanaassignments/snowflake/sf-org-pipeline/dbt/healthcare'
PROFILE_DIR = '/mnt/c/Users/sanja/.dbt'

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'retries': 1
}


with DAG(dag_id="Six_dag_dbt_snowflake",
        default_args=default_args,
        description='A DAG to run dbt commands for Snowflake',
        start_date=datetime(2025,7,31),
        schedule='@hourly',
        catchup=False,
    ) as dag:

    start = EmptyOperator(task_id='start_dag')

    with TaskGroup(group_id = "dbt_tasks") as dbt_tasks:
        dbt_debug = BashOperator(
            task_id='dbt-debug',
            bash_command=f'dbt debug --profiles-dir {PROFILE_DIR} --project-dir {PROJECT_DIR}'
        )

        dbt_run = BashOperator(
            task_id='dbt-run',
            bash_command=f'dbt run --profiles-dir {PROFILE_DIR} --project-dir {PROJECT_DIR}'
        )

        dbt_debug >> dbt_run


    end = EmptyOperator(task_id='end_dag')


    start >> dbt_tasks >> end


