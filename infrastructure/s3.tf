resource "aws_s3_bucket" "avatars" {
  bucket = "grocerymate-avatars-848757882765" # z. B. deine AWS Account ID anhängen

  versioning {
    enabled = true
  }

  tags = {
    Name        = "grocerymate-avatars"
    Environment = "Dev"
  }

  acl = "private"
}

