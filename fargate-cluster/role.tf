resource "aws_iam_role" "task_role" {
  name = "ecs_tasks-${var.family_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "task_role_policy" {
  name = "ecs_tasks-${var.family_name}-policy"
  role = aws_iam_role.task_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
          {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject"
          ],
          "Resource": [
            "arn:aws:s3:::env-bucket.terraforma/*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetBucketLocation"
          ],
          "Resource": [
            "arn:aws:s3:::env-bucket.terraforma/*"
          ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": ["*"]
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "logs:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Resource": [
              "*"
            ],
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:DescribeLogStreams"
            ]
        }
    ]

}
EOF
}

resource "aws_iam_role" "main_ecs_tasks" {
  name = "main_ecs_tasks-${var.family_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main_ecs_tasks" {
  name = "main_ecs_tasks-${var.family_name}-policy"
  role = aws_iam_role.main_ecs_tasks.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": ["*"]
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "logs:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Resource": [
              "*"
            ],
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:DescribeLogStreams"
            ]
        }
    ]

}
EOF
}

