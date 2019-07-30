#------------storage/main.tf---------

resource "aws_s3_bucket" "jenkins_home_bucket" {
  bucket_prefix = "${var.jenkins_bucket_name}-"
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

resource "aws_s3_bucket_object" "bucket_obj_base_jenkins_home" {
  key        = "bucket_obj_base_jenkins_home_key"
  bucket     = "${aws_s3_bucket.jenkins_home_bucket.id}"
  source     = "${file("${path.module}/files/${var.current_base_jenkins_home_filename}")}"
  kms_key_id = "${var.srv_account_kms.arn}"
}