gen_module_docs: fmt
	terraform-docs .
	terraform-docs markdown --hide requirements ./modules/app_registration > ./modules/app_registration/README.md
	terraform-docs markdown --hide requirements ./modules/controller_build > ./modules/controller_build/README.md
	terraform-docs markdown --hide requirements ./modules/copilot_build > ./modules/copilot_build/README.md
	terraform-docs markdown --hide requirements ./modules/azure_marketplace_agreement > ./modules/azure_marketplace_agreement/README.md
	terraform-docs markdown --hide requirements ./modules/account_onboarding > ./modules/account_onboarding/README.md

fmt:
	terraform fmt -recursive
