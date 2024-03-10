resource "aws_s3_bucket" "html_files" {
  bucket = var.s3_bucket_html

  tags = {
    Name = "HTMLFiles"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "html_to_s3_encryption" {
  bucket = aws_s3_bucket.html_files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


