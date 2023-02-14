resource "aws_ecr_repository" "demo_repository" {
  name                 = "demo-webapp-docker"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
  }
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "demo-repo-policy" {
  repository = aws_ecr_repository.demo_repository.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "arn:aws:ecr:*:109968515111:repository/*",
        "Action": "*"
      }
    ]
  }
  EOF
}
