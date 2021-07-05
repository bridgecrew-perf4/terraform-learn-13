provider "aws" {
  region  = "ap-southeast-1"
}

resource "aws_cloudwatch_metric_alarm" "CwAlarm" {
  alarm_name = "s3_creation_deletion"
  alarm_description = "A CloudWatch Alarm that triggers when an S3 Bucket is created or deleted."
  metric_name = "S3BucketActivityEventCount"
  namespace = "CloudTrailMetrics"
  statistic = "Sum"
  period = "300"
  threshold = "1"
  evaluation_periods = "1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions = [ data.aws_sns_topic.Default_CloudWatch_Alarms_ec2.arn ]
  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "MetricFilter" {
  log_group_name = "s3-create-del-status"
  pattern = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = DeleteBucket) || ($.eventName = CreateBucket)) }"
  name = "S3BucketActivityEventCount"

  metric_transformation {
    name = "S3BucketActivityEventCount"
    value = "1"
    namespace = "CloudTrailMetrics"
  }

}

data "aws_sns_topic" "Default_CloudWatch_Alarms_ec2" {
  name = "Default_CloudWatch_Alarms_ec2"
}