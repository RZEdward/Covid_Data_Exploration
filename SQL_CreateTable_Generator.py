import pandas as pd
import numpy as np

csv_file = 'C:/1Projects/1_Covid_Vaccinations.csv'

df = pd.read_csv(csv_file)

column_data_types = {}

for column in df.columns:
    if df[column].dtype == 'float64':
        column_data_types[column] = 'NUMERIC(16, 3)'
    else:
        numeric_values = pd.to_numeric(df[column], errors='coerce')
        max_value = numeric_values.max()
    
        if not pd.isnull(max_value) and max_value > 99999999:
            column_data_types[column] = 'BIGINT'
        else:
            if 'date' in column.lower():
                column_data_types[column] = 'DATE'
            else:
                if df[column].dtype == 'object':
                    column_data_types[column] = 'VARCHAR(255)'
                else:
                    if pd.to_numeric(df[column], errors='coerce').notna().all():
                        column_data_types[column] = 'INTEGER'
                    else:
                        column_data_types[column] = 'undefined'

create_table_sql = "CREATE TABLE VACCINATIONS (\n"
for column, data_type in column_data_types.items():
    create_table_sql += f"    {column} {data_type},"
create_table_sql = create_table_sql.rstrip(',\n') + "\n);"

print(create_table_sql)
