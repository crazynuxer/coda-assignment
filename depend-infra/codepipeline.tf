resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = var.s3_codepipeline_artifact
}

resource "aws_codepipeline" "coda_pipeline" {
  name     = "coda-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        BranchName           = "main"
        ConnectionArn        = var.codepipeline_connection_arn
        OutputArtifactFormat = "CODE_ZIP"
        FullRepositoryId     = "crazynuxer/coda-assignment"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.coda_project.name
      }
    }
  }
}
