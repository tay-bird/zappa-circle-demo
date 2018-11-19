# zappa-circle-demo
A demo integration of Zappa and CircleCI for CD

## IAM Configuration

It's not a great idea to run with more permissions than needed. By default, Zappa provides write access to S3, EC2, and other important compute services. Use an **execution policy** to limit what it can do.

You may also want to limit the permissions of the entity that deploys a Zappa project - for example, you may want to deploy your Zappa project via CI. In this case, use a **deploy policy**. If the entity is using IAM Access Keys, you will also need a **deploy role**.

### Execution Policy

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "arn:aws:lambda:*:*:function:*"
        }
    ]
}

```

### Deploy Role

The deploy role must include lambda.amazonaws.com, apigateway.amazonaws.com, and events.amazonaws.com as trusted entities.

### Deploy Policy

```

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "cloudwatch:GetMetricData",
                "events:PutRule",
                "lambda:GetAccountSettings",
                "lambda:CreateEventSourceMapping",
                "cloudwatch:ListMetrics",
                "cloudwatch:DescribeAlarmHistory",
                "cloudwatch:DescribeAlarmsForMetric",
                "cloudwatch:ListDashboards",
                "s3:HeadBucket",
                "cloudwatch:GetMetricWidgetImage",
                "events:PutEvents",
                "lambda:UpdateEventSourceMapping",
                "cloudwatch:GetDashboard",
                "lambda:ListFunctions",
                "apigateway:*",
                "lambda:GetEventSourceMapping",
                "cloudwatch:GetMetricStatistics",
                "events:TestEventPattern",
                "events:PutPermission",
                "events:DescribeEventBus",
                "events:PutTargets",
                "s3:ListAllMyBuckets",
                "lambda:ListEventSourceMappings",
                "cloudwatch:DescribeAlarms",
                "events:RemovePermission",
                "lambda:DeleteEventSourceMapping"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "apigateway:*"
            ],
            "Resource": [
                "arn:aws:apigateway:*::*/*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "events:*",
            "Resource": "arn:aws:events:*:*:rule/*"
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::zappa-*/*",
                "arn:aws:s3:::zappa-*"
            ]
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": "lambda:*",
            "Resource": "arn:aws:lambda:*:*:function:*"
        },
        {
            "Sid": "VisualEditor5",
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::*:role/zappa-execute-role"
            ]
        }
    ]
}

```

