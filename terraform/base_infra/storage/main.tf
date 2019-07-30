#------------storage/main.tf---------

resource "aws_s3_bucket" "jenkins_home_bucket" {
  bucket_prefix = "${var.tags_executedby}"
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${var.srv_account_kms.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = true
  }
}

