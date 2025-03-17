# ecr-push

> [!IMPORTANT]  
> This action was originally developed by [kciter](https://github.com/kciter) and removed from the fork network to be maintained as a standalone repository.
> The main difference between the projects is to support pulling images from Docker Hub using credentials.

This Action allows you to create Docker images and push into a ECR repository.

## Parameters
| Parameter                      | Type      | Default            | Description                                                                                                                                                    |
|--------------------------------|-----------|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `access_key_id`                | `string`  |                    | Your AWS access key id                                                                                                                                         |
| `secret_access_key`            | `string`  |                    | Your AWS secret access key                                                                                                                                     |
| `account_id`                   | `string`  |                    | Your AWS Account ID                                                                                                                                            |
| `repo`                         | `string`  |                    | Name of your ECR repository                                                                                                                                    |
| `region`                       | `string`  |                    | Your AWS region                                                                                                                                                |
| `create_repo`                  | `boolean` | `false`            | Set this to true to create the repository if it does not already exist                                                                                         |
| `set_repo_policy`              | `boolean` | `false`            | Set this to true to set a IAM policy on the repository                                                                                                         |
| `repo_policy_file`             | `string`  | `repo-policy.json` | Set this to repository policy statement json file. only used if the set_repo_policy is set to true                                                             |
| `image_scanning_configuration` | `boolean` | `false`            | Set this to True if you want AWS to scan your images for vulnerabilities                                                                                       |
| `tags`                         | `string`  | `latest`           | Comma-separated string of ECR image tags (ex latest,1.0.0,)                                                                                                    |
| `dockerhub_username`           | `string`  |                    | Docker Hub username                                                                                                                                            |
| `dockerhub_token`              | `string`  |                    | Docker Hub Personal Access Token                                                                                                                               |
| `dockerfile`                   | `string`  | `Dockerfile`       | The path to the Dockerfile to be used (e.g., path/to/Dockerfile)                                                                                               |
| `extra_build_args`             | `string`  | `""`               | Extra flags to pass to docker build (see docs.docker.com/engine/reference/commandline/build)                                                                   |
| `cache_from`                   | `string`  | `""`               | Images to use as cache for the docker build (see `--cache-from` argument docs.docker.com/engine/reference/commandline/build)                                   |
| `path`                         | `string`  | `.`                | Path to Dockerfile, defaults to the working directory                                                                                                          |
| `prebuild_script`              | `string`  |                    | Relative path from top-level to script to run before Docker build                                                                                              |
| `registry_ids`                 | `string`  |                    | : A comma-delimited list of AWS account IDs that are associated with the ECR registries. If you do not specify a registry, the default ECR registry is assumed |

## Usage

```yaml
jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: pier-digital/ecr-push@v1
      with:
        access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        account_id: ${{ secrets.AWS_ACCOUNT_ID }}
        dockerhub_username: ${{ secrets.DOCKERHUB_USERNAME }}
        dockerhub_token: ${{ secrets.DOCKERHUB_TOKEN }}
        repo: docker/repo
        region: us-east-1
        tags: latest,${{ github.sha }}
        create_repo: true
        image_scanning_configuration: true
        set_repo_policy: true
        repo_policy_file: repo-policy.json
```

## License
The MIT License (MIT)
