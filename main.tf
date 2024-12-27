# Define an archive_file datasource that creates the lambda archive
data "archive_file" "lambda" {
 type        = "zip"
 source_file = "hello.py"
 output_path = "hello.zip"
}

resource "aws_lambda_function" "yap-process-s3events" {
 function_name = "yap-process-s3events"
 role          = aws_iam_role.lambda_exec_role.arn
 handler       = "hello.lambda_handler"
 runtime       = "python3.8"
 filename      = data.archive_file.lambda.output_path
}

# aws_cloudwatch_log_group to get the logs of the Lambda execution.
resource "aws_cloudwatch_log_group" "lambda_log_group" {
 name              = "/aws/lambda/yap-process-s3events"
 retention_in_days = 14
}