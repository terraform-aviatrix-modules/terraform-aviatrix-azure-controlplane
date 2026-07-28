---
name: release-prep
description: "Use when preparing a module release, including version updates in docs, compatibility matrix updates, release note updates, and running make-based documentation generation. Triggers on: release prep, prepare release, cut release, update release notes, compatibility update."
---

# Release Preparation

## Goal
Prepare a release by applying required version/documentation updates and regenerating module documentation.

## Inputs
- Release version (example: v1.1.0)
- Terraform compatibility for the release (example: >=1.3.0)
- Release note bullets for the new version

## Steps
1. Update HEADER.md compatibility row for the release version and Terraform compatibility.
2. Update COMPATIBILITY.md with the release version entry at the top.
3. Update RELEASE_NOTES.md with a section for the release and concise bullets.
4. Run make gen_module_docs
5. Validate diff only includes intended changes.

## Output Checklist
- HEADER.md updated
- COMPATIBILITY.md updated
- RELEASE_NOTES.md updated
- make gen_module_docs succeeded
