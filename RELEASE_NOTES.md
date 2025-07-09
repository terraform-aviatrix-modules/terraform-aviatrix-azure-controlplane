# terraform-aviatrix-azure-controlplane - release notes

## v1.1.2
- Update security group entries for controller to allow copilot to connect on tcp ports 50441-50443.

## v1.1.1
- Allow for configuring copilot and controller existing public ip (Thanks @dspinhirne)
- Added a number of configuration options (Thanks @PiotrAviatrix)

## v1.1.0
- Now supports g4 images (v8.0.0)

## v1.0.4
- Found and resolved another issue with terracurl on destroy, in the onboarding submodule.

## v1.0.3
- Bump init module versions, to solve issue with terracurl on destroy.

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