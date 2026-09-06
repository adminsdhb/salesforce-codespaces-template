# repository-governance Specification

## Purpose
Define the baseline contributor workflow and guardrails for maintaining this Salesforce Codespaces template.

## Requirements
### Requirement: OpenSpec is available in the template environment

The repository SHALL provide OpenSpec as part of its standard development environment so contributors can use spec-driven workflows without extra manual setup.

#### Scenario: Contributor opens the Codespace
- **WHEN** the development container finishes building
- **THEN** the `openspec` CLI is available on `PATH`
- **AND** the repository includes GitHub Copilot OpenSpec prompts and skills

#### Scenario: Repository validation runs
- **WHEN** `bash scripts/validate.sh` runs locally or in CI
- **THEN** validation confirms the required OpenSpec files exist
- **AND** validation runs OpenSpec's strict project validation when the CLI is available

#### Scenario: OpenSpec is unavailable outside the standard environment
- **WHEN** `bash scripts/validate.sh` runs on a host without the `openspec` CLI
- **THEN** validation still checks the repository's required files and JSON configuration
- **AND** it reports that strict OpenSpec validation was skipped

### Requirement: Non-trivial changes start from OpenSpec planning

Contributors SHALL create or update OpenSpec planning artifacts before implementing non-trivial repository changes.

#### Scenario: Contributor prepares a non-trivial template change
- **WHEN** the contributor is about to change repository behavior, tooling, automation, or documentation in a meaningful way
- **THEN** they start with `/opsx-explore` or `/opsx-propose`
- **AND** they keep the resulting `openspec/changes/` artifacts with the same change

#### Scenario: Contributor finishes an implemented change
- **WHEN** the repository change is complete
- **THEN** the contributor syncs or archives the related OpenSpec change so the main specs stay current

### Requirement: OpenSpec artifacts stay template-safe

OpenSpec artifacts SHALL describe reusable template behavior and must not introduce org-specific or secret material.

#### Scenario: Planning a repository change
- **WHEN** proposal, design, spec, or task artifacts are created or updated
- **THEN** they describe generic Salesforce DX template behavior
- **AND** they do not include usernames, passwords, security tokens, auth URLs, certificates, or other secrets
