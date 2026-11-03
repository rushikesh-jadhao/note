import json
import boto3

sns = boto3.client('sns')

SNS_TOPIC_ARN = 'YOUR_SNS_TOPIC_ARN'

def lambda_handler(event, context):

    for record in event['Records']:

        event_name = record['eventName']
        bucket_name = record['s3']['bucket']['name']
        file_name = record['s3']['object']['key']

        message = f"""
        S3 Event Notification

        Event: {event_name}
        Bucket: {bucket_name}
        File: {file_name}
        """

        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="S3 File Notification",
            Message=message
        )

    return {
        'statusCode': 200,
        'body': json.dumps('Notification sent successfully')
    }


-------------------------------------------------------------------
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": "YOUR_SNS_TOPIC_ARN"
    }
  ]
}
