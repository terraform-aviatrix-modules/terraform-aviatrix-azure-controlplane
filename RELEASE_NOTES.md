# terraform-aviatrix-azure-controlplane - release notes

## v1.1.0
- Now supports g4 images (v8.0.0)

## v1.0.2
- Enabled Controller security group management
- Fix issue where NSG throws an error getting a null in stead of a string, when disabling deployment of copilot.
- Bump copilot init to version 1.0.4.

## v1.0.1
- Remove unnecessary data sources
- Update copilot init module version
- Add input validation for controller name

## v1.0.0
v1.0.0 - Initial release