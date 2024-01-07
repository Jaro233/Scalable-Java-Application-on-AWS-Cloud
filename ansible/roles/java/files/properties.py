import boto3
import json

def get_secret(secret_name, region_name):
    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(service_name='secretsmanager', region_name=region_name)

    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    except Exception as e:
        raise e
    else:
        if 'SecretString' in get_secret_value_response:
            secret = get_secret_value_response['SecretString']
            return json.loads(secret)
        else:
            raise Exception("Secret string not found in response")

def get_parameter(parameter_name, region_name):
    # Create a SSM client
    session = boto3.session.Session()
    client = session.client(service_name='ssm', region_name=region_name)

    try:
        response = client.get_parameter(Name=parameter_name)
    except Exception as e:
        raise e
    else:
        return response['Parameter']['Value']

def update_properties_file(db_url, username, password, filepath):
    with open(filepath, 'r') as file:
        data = file.readlines()

    for i, line in enumerate(data):
        if line.startswith('spring.datasource.url='):
            data[i] = f'spring.datasource.url={db_url}\n'
        elif line.startswith('spring.datasource.username='):
            data[i] = f'spring.datasource.username={username}\n'
        elif line.startswith('spring.datasource.password='):
            data[i] = f'spring.datasource.password={password}\n'

    with open(filepath, 'w') as file:
        file.writelines(data)

def main():
    region_name = 'us-east-1'  # e.g. 'us-west-2'
    secret_name = 'dev-rds-db-4'
    parameter_name = '/dev/petclinic/rds_endpoint'
    properties_file_path = '/opt/application.properties'

    # Get credentials and endpoint
    secret = get_secret(secret_name, region_name)
    rds_endpoint = get_parameter(parameter_name, region_name)

    # Update application.properties file
    db_url = f'jdbc:mysql://{rds_endpoint}/petclinic'  # Replace 'database-name' with your actual database name
    update_properties_file(db_url, secret['username'], secret['password'], properties_file_path)

if __name__ == '__main__':
    main()
