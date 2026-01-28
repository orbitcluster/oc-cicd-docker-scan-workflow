# CI/CD Docker Image Scan Workflow

## Mission & Purpose

This repository provides a reusable GitHub Action to perform **Vulnerability Scanning** on Docker images using [Trivy](https://github.com/aquasecurity/trivy). Its goal is to ensure that container images are free from critical and high-severity security vulnerabilities before they are deployed or pushed to a registry.

It can detect:
*   **OS Vulnerabilities** (e.g., in `apt`, `apk`, `yum` packages).
*   **Library Vulnerabilities** (e.g., in `Gemfile`, `package-lock.json`, `pom.xml`, etc.).

## Features

*   **Composite Action**: Easily reusable in other workflows.
*   **Trivy
    - Scans the image using `aquasecurity/trivy-action`.
    - Generates a Markdown report using a custom template.
    - Fails on 'CRITICAL,HIGH' vulnerabilities.
    - **PR Commenting**: If running on a PR and vulnerabilities are found, it posts the formatted table to the PR.
*   **Quality Gates**: Fails the build if `CRITICAL` or `HIGH` vulnerabilities are detected.

## Inputs

| Input          | Description                                         | Required | Default               |
| :------------- | :-------------------------------------------------- | :------- | :-------------------- |
| `image-name`   | Name of the Docker image to scan (e.g., `my-app`).  | **Yes**  | N/A                   |
| `image-tag`    | Tag of the Docker image to scan (e.g., `latest`).   | **Yes**  | N/A                   |
| `github-token` | GitHub Token for commenting on PRs.                 | **Yes**  | `${{ github.token }}` |

## Usage

### Example Workflow

Add the following step to your `.github/workflows/build.yml` (after building your docker image):

```yaml
jobs:
  build-and-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Build Docker Image
        run: docker build -t my-app:${{ github.sha }} .

      - name: Scan Docker Image
        uses: orbitcluster/oc-cicd-docker-scan-workflow@v1
        with:
          image-name: 'my-app'
          image-tag: ${{ github.sha }}
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Development

### Pre-commit Hooks

This repository uses [pre-commit](https://pre-commit.com) to maintain code quality.

1.  Install pre-commit: `pip install pre-commit`
2.  Install hooks: `pre-commit install`
3.  Run manually: `pre-commit run --all-files`

### Versioning

This repository follows semantic versioning. Releases are automatically managed by the `.github/workflows/version.yml` workflow on pushes to the `main` branch.

## License

Copyright © 2026 OrbitCluster. All rights reserved.
