resource "aws_s3_bucket" "remote_state" {
  bucket = var.bucket_name
}


resource "aws_s3_bucket_versioning" "remote_state" {
  count = var.enable_versioning ? 1 : 0

  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
